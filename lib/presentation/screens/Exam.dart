import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vibration/vibration.dart';
import 'package:weva/presentation/widgets/default_button.dart';

import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../../back/models/subject.dart';
import '../../constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../translations/locale_keys.g.dart';
import '../widgets/alert_dialog.dart';
import 'dart:math' as math;



// ignore_for_file: prefer_const_constructors
class Exam extends StatefulWidget {
  Exam({Key? key, required this.videoID, required this.userID, required this.type, required this.subjectName}) : super(key: key);

  String videoID;
  String userID;
  String type;
  String subjectName;

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  Color linearColor = Colors.green;
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 120);

  void setCountDown() {
    final reduceSecondsBy = 1;
    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      setState(() {
        countdownTimer!.cancel();
      });

      finishExam();

    } else {
      setState(() {
        myDuration = Duration(seconds: seconds);
      });
    }
  }

  void startTimer() {
    setState(() {
      countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
        setCountDown();
        Colouring(
          SecondsMonitor: myDuration.inSeconds,
        );
      });
    });
  }

  void stopTimer() {
    setState(() {
      countdownTimer!.cancel();
    });
  }

  void resetTimer() {
    setState(() {
      stopTimer();
      myDuration = Duration(seconds: 5);
    });
  }

  void Colouring({
    required SecondsMonitor,
  }) {
    if (SecondsMonitor > 60) {
      setState(() {
        linearColor = Colors.green;
      });
    } else if (SecondsMonitor <= 60 && SecondsMonitor > 30) {
      setState(() {
        linearColor = Colors.amber;
      });
    } else if (SecondsMonitor <= 30) {
      setState(() {
        linearColor = Colors.red;
      });
    } else {
      setState(() {
        linearColor = dodblue;
      });
    }
  }


  Widget buildTimer() {
    final secondsMonitor = myDuration.inSeconds;
    return Column(
      children: [
        Text(
          '${myDuration.inSeconds.toString().padLeft(2, '0')}',
          style: GoogleFonts.rubik(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Color(0xff70798C),
          ),
        ),
      ],
    );
  }

  void TimeFinished() {
    // myDuration.inSeconds==0?
  }


  @override
  void initState() {
    super.initState();
    //startTimer();

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));


    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 4));


    getQuestions();

  }

  int questionNumber = 1;

  List x = [0, 0, 0, 0];

  bool greenBorderandShadow = false;

  String questionn = '';


  List<question> questions = [];

  bool loadingg = true;


  int rightAnswer = 0;


  void getQuestions()async{

    //log(widget.chOrVidID);
   // _controllerBottomCenter.play();
    questions = [];

    if(await checkConnectionn()){

      loading(context: context);
      setState((){
        loadingg = true;
      });

      FirebaseFirestore.instance.collection(widget.type).where("chOrVidID", isEqualTo: widget.videoID).get(const GetOptions(source: Source.server))
          .then((value) {


        final List<question> loadData = [];

        for (var element in value.docs) {
          //element.data();
          //log(element.data()['nameAr'].toString());

          loadData.add(question(
            idToEdit: element.id,
            questionText: element.data()['questionText'] ?? "",
            ansOne: element.data()['ansOne'] ?? "",
            ansTwo: element.data()['ansTwo'] ?? "",
            ansThree: element.data()['ansThree'] ?? "",
            ansFour: element.data()['ansFour'] ?? "",
            correctAns: element.data()['correctAns'] ?? 0,
            subjectID: element.data()['subjectID'] ?? "",
            chOrVidID: element.data()['chOrVidID'] ?? "",
            qNum: element.data()['qNum'] ?? 0,


            userDoneAction: "",
            LastUserDoneAction: "",
            status: element.data()['status'] ?? "",

          ));
        }

        loadData.sort((a, b) => a.qNum.compareTo(b.qNum));

        setState(() {
          questions = loadData;
        });

        log(questions.length.toString());

        Navigator.of(context).pop();

        setState((){
          loadingg = false;
        });

        startTimer();

      }).onError((error, stackTrace) {

        log(error.toString());
        showToast("Error: $error");

      });

    }else{

      showToast("Check Internet Connection !");

    }

  }



  Future<void> checkAns(studentAns, correctAns) async {
    log(studentAns.toString());
    log(correctAns.toString());

    setState(() {
      clickable = false;
    });

    if(studentAns == correctAns){
      //right answer
      x[correctAns - 1] = 1;

      rightAnswer = rightAnswer + 1;

    }else{
      //wrong answer

      for (int i = 1; i <= x.length+1; i++) {
        if (i == correctAns){
          x[i - 1] = 3;
        }else if (i == studentAns){
          x[i - 1] = 2;
        }

      }


      if (!kIsWeb && (await Vibration.hasVibrator() ?? false)) {
            Vibration.vibrate();
      }


    }



    Timer.periodic(const Duration(seconds: 2), (timer) => {
      nextQuestion(),
      timer.cancel()
    });

  }

  bool clickable = true;


  void nextQuestion(){

    if(questionNumber < questions.length){

      setState(() {

        questionNumber = questionNumber + 1;
        x = [0, 0, 0, 0];


        clickable = true;
      });

    }else{
      //answered last Question

      finishExam();

    }



  }




  late ConfettiController _controllerCenter;
  late ConfettiController _controllerBottomCenter;

  void startAnmitios(){
    _controllerCenter.play();
    _controllerBottomCenter.play();

  }
  void stopAnmitios(){
    _controllerCenter.stop();
    _controllerBottomCenter.stop();

  }


  Widget scoreAlert(context, String text1, String text2) => AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    title: Column(
      children: [
        Text(
          text1,
          style: GoogleFonts.rubik(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Text(
          text2,
          style: GoogleFonts.rubik(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        ConfettiWidget(
          confettiController: _controllerCenter,
          blastDirection: - math.pi / 2,
          emissionFrequency: 0.01,
          numberOfParticles: 20,
          maxBlastForce: 100,
          minBlastForce: 80,
          gravity: 0.3,
        )
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultButton(
            context: context,
            color: Colors.white70,
            textColor: Colors.black,
            text: LocaleKeys.cancel.tr(),
            onpressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
    ],
  );



  Future<void> finishExam() async {

    stopTimer();
    resetTimer();
   // startAnmitios();
    log(((100 * rightAnswer) / questions.length).toString());

    if(((100 * rightAnswer) / questions.length) > 50){

      startAnmitios();

    }

    clickable = false;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return scoreAlert(
            context,
            "your Score",
            "you answered $rightAnswer out of ${questions.length}"
          );
        });


    if(await checkConnectionn()){

    loading(context: context);

    FirebaseFirestore.instance.collection('testArchive').add({
    'studentID': FirebaseAuth.instance.currentUser!.uid ?? "-",
    'chOrVidID': widget.videoID,
    'type': widget.type,
    'subjectName': widget.subjectName,
    'rightAns': rightAnswer,
    'totalAns': questions.length,

    'dateCreated': DateTime.now(),

    })
        .then((value) {


      FirebaseFirestore.instance.collection('lastTestScore').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'studentID': FirebaseAuth.instance.currentUser!.uid ?? "-",
        'chOrVidID': widget.videoID,
        'type': widget.type,
        'subjectName': widget.subjectName,
        'rightAns': rightAnswer,
        'totalAns': questions.length,

        'dateCreated': DateTime.now(),

      })
          .then((value) {

        Navigator.of(context).pop();


      })
          .catchError((error) {

        showToast("Failed to add: $error");
        print("Failed to add: $error");

      });

    })
        .catchError((error) {

    showToast("Failed to add: $error");
    print("Failed to add: $error");

    });

    }else{

    showToast("Check Internet Connection !");

    }


  }



  @override
  void dispose() {

    _controllerCenter.dispose();
    _controllerBottomCenter.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return loadingg? Container()
          : Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        stopTimer();
                        resetTimer();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    Icon(
                      Icons.timer_outlined,
                      size: 30.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      '${myDuration.inSeconds.toString()}${LocaleKeys.s_remaining.tr()}',
                      style: GoogleFonts.rubik(
                        fontSize: 18.0,
                        color: linearColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  child: LinearPercentIndicator(
                    padding: EdgeInsets.all(0.0),
                    width: MediaQuery.of(context).size.width,
                    percent: myDuration.inSeconds / 120,
                    barRadius: Radius.circular(20),
                    // animation: true,
                    // animationDuration: 1500,
                    progressColor: linearColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${LocaleKeys.question.tr()} $questionNumber ${LocaleKeys.of.tr()} ${questions.length}',
                          style: GoogleFonts.rubik(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          //$question
                          questions[questionNumber-1].questionText,
                          style: GoogleFonts.rubik(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index) => Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 2,
                            shadowColor: Colors.grey,
                            color: x[index] == 0
                                ? Colors.white
                                : x[index] == 1
                                ? Color(0xff45CB6A)
                                : x[index] == 2
                                ? Colors.red.shade700
                                : Colors.white,
                            child: Container(
                              decoration: x[index] == 3
                                  ? BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xff45CB6A),
                                  width: 2,
                                ),
                              )
                                  : BoxDecoration(),
                              child: ListTile(
                                title: Text(
                                  index == 0 ? questions[questionNumber-1].ansOne : index == 1? questions[questionNumber-1].ansTwo : index == 2? questions[questionNumber-1].ansThree : questions[questionNumber-1].ansFour,
                                  style: GoogleFonts.rubik(
                                    color: x[index] == 0 || x[index] == 3
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ),
                                leading: IconButton(
                                  onPressed: () {

                                    if(clickable){
                                      checkAns(index + 1, questions[questionNumber-1].correctAns);
                                    }

                                  },
                                  icon: x[index] == 0
                                      ? Icon(
                                    greenBorderandShadow
                                        ? Icons.panorama_fish_eye
                                        : Icons.lens,
                                    color: greenBorderandShadow
                                        ? Color(0xff45CB6A)
                                        : Colors.grey,
                                  )
                                      : x[index] == 1
                                      ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                      : x[index] == 2
                                      ? Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  )
                                      : x[index] == 3
                                      ? Icon(
                                    Icons
                                        .panorama_fish_eye,
                                    color:
                                    Color(0xff45CB6A),
                                  )
                                      : Icon(
                                    Icons
                                        .panorama_fish_eye,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {

                                    if(clickable){
                                      checkAns(index+1, questions[questionNumber-1].correctAns);
                                    }

                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Material(
                  // shadowColor: Colors.grey.withAlpha(40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(15.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //$question
                          '${widget.subjectName} ${LocaleKeys.exam.tr()}',
                          style: GoogleFonts.rubik(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /* SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                ' $questionNumber / questions.length',
                                style: GoogleFonts.rubik(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_back_outlined,
                                  size: 25,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              webdefaultButton(
                                  text: 'Submit',
                                  onpressed: () {},
                                  color: dodblue,
                                  context: context),
                            ],
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

            Align(
              alignment: Alignment.bottomCenter,
              child: ConfettiWidget(
                confettiController: _controllerBottomCenter,
                blastDirection: -math.pi / 2,
                emissionFrequency: 0.01,
                numberOfParticles: 20,
                maxBlastForce: 100,
                minBlastForce: 80,
                gravity: 0.3,
              ),
            )

          ],
        ),
      );
    }
    else {
      return loadingg? Container()
          : Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      stopTimer();
                      resetTimer();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Icon(
                    Icons.timer_outlined,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    '${myDuration.inSeconds.toString()}${LocaleKeys.s_remaining.tr()}',
                    style: GoogleFonts.rubik(
                      fontSize: 18.0,
                      color: linearColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                child: LinearPercentIndicator(
                  padding: EdgeInsets.all(0.0),
                  width: MediaQuery.of(context).size.width,
                  percent: myDuration.inSeconds / 120,
                  barRadius: Radius.circular(20),
                  // animation: true,
                  // animationDuration: 1500,
                  progressColor: linearColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${LocaleKeys.question.tr()} $questionNumber ${LocaleKeys.of.tr()} ${questions.length}',
                        style: GoogleFonts.rubik(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                        //$question
                        questions[questionNumber-1].questionText,
                        style: GoogleFonts.rubik(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) => Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 2,
                          shadowColor: Colors.grey,
                          color: x[index] == 0
                              ? Colors.white
                              : x[index] == 1
                              ? Color(0xff45CB6A)
                              : x[index] == 2
                              ? Colors.red.shade700
                              : Colors.white,
                          child: Container(
                            decoration: x[index] == 3
                                ? BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xff45CB6A),
                                width: 2,
                              ),
                            )
                                : BoxDecoration(),
                            child: ListTile(
                              title: Text(
                                index == 0 ? questions[questionNumber-1].ansOne : index == 1? questions[questionNumber-1].ansTwo : index == 2? questions[questionNumber-1].ansThree : questions[questionNumber-1].ansFour,
                                style: GoogleFonts.rubik(
                                  color: x[index] == 0 || x[index] == 3
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 17.0,
                                ),
                              ),
                              leading: IconButton(
                                onPressed: () {

                                  if(clickable){
                                    checkAns(index+1, questions[questionNumber-1].correctAns);
                                  }

                                },
                                icon: x[index] == 0
                                    ? Icon(
                                  greenBorderandShadow
                                      ? Icons.panorama_fish_eye
                                      : Icons.lens,
                                  color: greenBorderandShadow
                                      ? Color(0xff45CB6A)
                                      : Colors.grey,
                                )
                                    : x[index] == 1
                                    ? Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                                    : x[index] == 2
                                    ? Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )
                                    : x[index] == 3
                                    ? Icon(
                                  Icons
                                      .panorama_fish_eye,
                                  color:
                                  Color(0xff45CB6A),
                                )
                                    : Icon(
                                  Icons
                                      .panorama_fish_eye,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                setState(() {

                                  if(clickable){
                                    checkAns(index+1, questions[questionNumber-1].correctAns);
                                  }

                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Material(
                // shadowColor: Colors.grey.withAlpha(40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(15.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //$question
                        '${widget.subjectName} ${LocaleKeys.exam.tr()}',
                        style: GoogleFonts.rubik(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
