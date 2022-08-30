// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../back/checLogin.dart';
import '../../constants.dart';
import '../../translations/locale_keys.g.dart';
import '../screens/1.dart';
import '../screens/AndroidLarg-32.dart';
import '../widgets/default_text_button.dart';
import '../widgets/registration_button.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      title: LocaleKeys.onboard1.tr(),
      image: 'assets/images/onboarding/on1.png',
      body: LocaleKeys.onboard2.tr(),
    ),
    BoardingModel(
      title: LocaleKeys.onboard3.tr(),
      image: 'assets/images/onboarding/on2.png',
      body: LocaleKeys.onboard4.tr(),
    ),
    BoardingModel(
      title: LocaleKeys.onboard5.tr(),
      image: 'assets/images/onboarding/on3.png',
      body: LocaleKeys.onboard6.tr(),
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          Row(
            children: [
              defaultTextButton(
                onpressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => checkLogin(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                text: LocaleKeys.skip.tr(),
                color: defaultColor,
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: SmoothPageIndicator(
                controller: boardController,
                count: boarding.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: defaultColor,
                  dotHeight: 6,
                  expansionFactor: 2,
                  dotWidth: 10,
                  spacing: 10,
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            registrationButton(
              onTap: () {
                if (isLast == false) {
                  boardController.nextPage(
                    duration: Duration(
                      milliseconds: 1500,
                    ),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => checkLogin(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              text: LocaleKeys.next.tr(),
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              model.title,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              model.body,
              style: GoogleFonts.montserrat(
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      );
}
