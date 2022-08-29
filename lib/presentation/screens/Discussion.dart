import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../constants.dart';
import '../widgets/default_button.dart';

class Discussion extends StatefulWidget {
  const Discussion({Key? key}) : super(key: key);

  @override
  State<Discussion> createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  Color linearColor = Colors.green;

  void TimeFinished() {
    // myDuration.inSeconds==0?
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Science discussion',
          style: GoogleFonts.rubik(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xffe4f1f8),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50.0,
                        left: 25.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //$question
                        'Which of the following influence the gravitational force?',
                        style: GoogleFonts.rubik(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: SingleChildScrollView(
                          child: ListView.separated(
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
                                      color:
                                          x == 0 ? Colors.black : Colors.white,
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
                                      x = 1;
                                      // greenBorderandShadow = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PrevButton(
                    text: 'Previous',
                    onpressed: () {},
                    context: context,
                  ),
                  Spacer(),
                  NextButton(
                    text: 'Next',
                    onpressed: () {},
                    context: context,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Material(
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
                // height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.call_end,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffe4f1f8),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.mic_off_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {}),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffe4f1f8),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.spatial_audio,
                            color: Colors.black,
                          ),
                          onPressed: () {}),
                    ),
                    Spacer(),
                    defaultButton(
                      text: 'Submit',
                      onpressed: () {


                      },
                      color: dodblue,
                      context: context,
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

Widget NextButton({
  required String text,
  required onpressed,
  required context,
  Icon? prefixIcon,
  Icon? suffixIcon,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          MaterialButton(
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            onPressed: onpressed,
          ),
          Icon(Icons.arrow_forward_rounded),
        ],
      ),
    );
Widget PrevButton({
  required String text,
  required onpressed,
  required context,
  Icon? prefixIcon,
  Icon? suffixIcon,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_back_outlined),
          MaterialButton(
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            onPressed: onpressed,
          ),
        ],
      ),
    );
