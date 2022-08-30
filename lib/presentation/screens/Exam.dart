import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weva/presentation/widgets/default_button.dart';

import '../../constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// ignore_for_file: prefer_const_constructors
class Exam extends StatefulWidget {
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
    startTimer();
  }

  int questionNumber = 1;

  int x = 0;
  bool greenBorderandShadow = false;
  String question = '';
  bool answerPressed = false;
  bool rightAnswerPressed = false;
  bool wrongAnswerPressed = false;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
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
                    '${myDuration.inSeconds.toString()}s remaining',
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
                        'QUESTION 20 OF 40  for u   $questionNumber / questions.length',
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
                        'Which of the following influence the gravitational force?',
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
                          color: x == 0
                              ? Colors.white
                              : x == 1
                                  ? Color(0xff45CB6A)
                                  : x == 2
                                      ? Colors.red.shade700
                                      : Colors.white,
                          child: Container(
                            decoration: greenBorderandShadow
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color(0xff45CB6A),
                                      width: 2,
                                    ),
                                  )
                                : BoxDecoration(),
                            child: ListTile(
                              title: Text(
                                'and',
                                style: GoogleFonts.rubik(
                                  color: x == 0 ? Colors.black : Colors.white,
                                  fontSize: 17.0,
                                ),
                              ),
                              leading: IconButton(
                                onPressed: () {},
                                icon: x == 0
                                    ? Icon(
                                        greenBorderandShadow
                                            ? Icons.panorama_fish_eye
                                            : Icons.lens,
                                        color: greenBorderandShadow
                                            ? Color(0xff45CB6A)
                                            : Colors.grey,
                                      )
                                    : x == 1
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          )
                                        : x == 2
                                            ? Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.panorama_fish_eye,
                                                color: Colors.white,
                                              ),
                              ),
                              onTap: () {
                                setState(() {
                                  //x=1;
                                  greenBorderandShadow = true;
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
                        'Science Exam',
                        style: GoogleFonts.rubik(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
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
                    '${myDuration.inSeconds.toString()}s remaining',
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
                        'QUESTION 20 OF 40  for u   $questionNumber / questions.length',
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
                        'Which of the following influence the gravitational force?',
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
                          color: x == 0
                              ? Colors.white
                              : x == 1
                                  ? Color(0xff45CB6A)
                                  : x == 2
                                      ? Colors.red.shade700
                                      : Colors.white,
                          child: Container(
                            decoration: greenBorderandShadow
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color(0xff45CB6A),
                                      width: 2,
                                    ),
                                  )
                                : BoxDecoration(),
                            child: ListTile(
                              title: Text(
                                'and',
                                style: GoogleFonts.rubik(
                                  color: x == 0 ? Colors.black : Colors.white,
                                  fontSize: 17.0,
                                ),
                              ),
                              leading: IconButton(
                                onPressed: () {},
                                icon: x == 0
                                    ? Icon(
                                        greenBorderandShadow
                                            ? Icons.panorama_fish_eye
                                            : Icons.lens,
                                        color: greenBorderandShadow
                                            ? Color(0xff45CB6A)
                                            : Colors.grey,
                                      )
                                    : x == 1
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          )
                                        : x == 2
                                            ? Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.panorama_fish_eye,
                                                color: Colors.white,
                                              ),
                              ),
                              onTap: () {
                                setState(() {
                                  //x=1;
                                  greenBorderandShadow = true;
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
                        'Science Exam',
                        style: GoogleFonts.rubik(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                            defaultButton(
                                text: 'Submit',
                                onpressed: () {},
                                color: dodblue,
                                context: context),
                          ],
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

// Widget buildQuestion({
//   required String Question,
// }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'question.text',
//         style: GoogleFonts.rubik(
//           color: Colors.black,
//           fontSize: 17.0,
//         ),
//
//         // ListView.separated(
//         //               physics: NeverScrollableScrollPhysics(),
//         //               separatorBuilder: (context, index) => SizedBox(
//         //                 height: MediaQuery.of(context).size.height * 0.02,
//         //               ),
//         //               shrinkWrap: true,
//         //               itemCount: 4,
//         //               itemBuilder: (context, index) => Material(
//         //                 borderRadius: BorderRadius.circular(10),
//         //                 elevation: 2,
//         //                 shadowColor: Colors.grey,
//         //                 child: ListTile(
//         //                   selectedTileColor: Colors.black,
//         //                   title: Text(
//         //                     'and',
//         //                     style: GoogleFonts.rubik(
//         //                       color: Colors.black,
//         //                       fontSize: 17.0,
//         //                     ),
//         //                   ),
//         //                   leading: IconButton(
//         //                     onPressed: () {},
//         //                     icon: answerPressed == false
//         //                         ? Icon(
//         //                             Icons.circle,
//         //                             color: Colors.grey,
//         //                           )
//         //                         : Icon(Icons.done),
//         //                   ),
//         //                   onTap: () {
//         //                     setState(() {
//         //                       answerPressed = true;
//         //                     });
//         //                   },
//         //                 ),
//         //               ),
//         //             ),
//       ),
//     ],
//   );
// }
// child: PageView.builder(
//   itemCount: 10, //questions.lenth
//   physics: NeverScrollableScrollPhysics(),
//   itemBuilder: (context, index) {
//     // final question =questions[index];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.02,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 stopTimer();
//                 resetTimer();
//               },
//               icon: Icon(
//                 Icons.close,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.2,
//             ),
//             Icon(
//               Icons.timer_outlined,
//               size: 30.0,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.02,
//             ),
//             Text(
//               '${myDuration.inSeconds.toString()}s remaining',
//               style: GoogleFonts.rubik(
//                 fontSize: 18.0,
//                 color: linearColor,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.03,
//         ),
//         Container(
//           child: LinearPercentIndicator(
//             padding: EdgeInsets.all(0.0),
//             width: MediaQuery.of(context).size.width,
//             percent: myDuration.inSeconds / 120,
//             barRadius: Radius.circular(20),
//             // animation: true,
//             // animationDuration: 1500,
//             progressColor: linearColor,
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.02,
//         ),
//         Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: buildQuestion(Question: 'question'),
//         ),
//       ],
//     );
//   },
// ),
