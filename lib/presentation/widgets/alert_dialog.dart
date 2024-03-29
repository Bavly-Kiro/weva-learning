import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:platform_info/platform_info.dart';
import 'package:weva/presentation/widgets/default_button.dart';

import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../../back/models/levels.dart';
import '../../constants.dart';
import '../../translations/locale_keys.g.dart';
import '../screens/6 sign in.dart';
import '../screens/Exam.dart';
import '../screens/Live.dart';
import 'friend_card.dart';

//
// Widget ClickAlert({
//   required title,
//   required content,
//   context,
//   YesOnPressed,
// }) =>
//     AlertDialog(
//       title: Text(title),
//       content: Text(content),
//       actions: [
//         TextButton(
//           onPressed: YesOnPressed,
//           child: Text(
//             'Yes',
//             style: Theme.of(context).textTheme.bodyText1,
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(
//             'No',
//             style: Theme.of(context).textTheme.bodyText1,
//           ),
//         ),
//       ],
//     );
double rating = 0;

TextEditingController notesController = TextEditingController();

Widget buildRating() => RatingBar(
    initialRating: rating,
    minRating: 1,
    maxRating: 5,
    itemSize: 30,
    itemPadding: EdgeInsets.symmetric(horizontal: 4),
    ratingWidget: RatingWidget(
      full: Icon(
        Icons.star,
        color: dodblue,
      ),
      half: Icon(
        Icons.star,
        color: dodblue,
      ),
      empty: Icon(
        Icons.star_border_outlined,
        color: dodblue,
      ),
    ),
    updateOnDrag: true,
    onRatingUpdate: (value) {
      rating = value;
    });

showRating({
  context,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('AS'),
        content: Text('ASD'),
      ),
    );

Widget rateAlert(context, videoID, userID) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image(
              //   image: AssetImage(
              //     "assets/images/wave.png",
              //   ),
              //   height: 50,
              //   width: 50,
              // ),
              Icon(
                Icons.cloud_done_outlined,
                color: dodblue,
                size: 100,
              ),
            ],
          ),
          Text(
            "${LocaleKeys.done.tr()} !",
            style: GoogleFonts.rubik(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            LocaleKeys.please_rate.tr(),
            style: GoogleFonts.rubik(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            child: TextField(
              controller: notesController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Write Notes Here',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          buildRating(),
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

                rating = 0;
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            defaultButton(
              color: dodblue,
              text: LocaleKeys.submit.tr(),
              onpressed: () async {
                if (await checkConnectionn()) {
                  loading(context: context);

                  FirebaseFirestore.instance.collection("Rates").add({
                    'userID': userID,
                    'videoID': videoID,
                    'text': notesController.text,
                    'rate': rating,
                  }).catchError((error) {
                    showToast("Failed to add: $error");
                    print("Failed to add: $error");
                  }).then((value) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                } else {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return noInternetAlert(
                          context,
                        );
                      });
                }
              },
              context: context,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );

Widget noInternetAlert(context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image(
              //   image: AssetImage(
              //     "assets/images/wave.png",
              //   ),
              //   height: 50,
              //   width: 50,
              // ),
              Icon(
                Icons.signal_wifi_connected_no_internet_4_rounded,
                color: dodblue,
                size: 100,
              ),
            ],
          ),
          Text(
            LocaleKeys.no_internet.tr(),
            style: GoogleFonts.rubik(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            LocaleKeys.please_internet.tr(),
            style: GoogleFonts.rubik(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
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
              },
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );

Widget textAlert(context, String text1, String text2) => AlertDialog(
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
              },
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );

Widget openExam(context, videoID, userID, type, subjectName) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: Column(
        children: [
          Text(
            LocaleKeys.be_ready.tr(),
            style: GoogleFonts.rubik(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
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
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            defaultButton(
              color: Colors.green,
              text: LocaleKeys.start.tr(),
              onpressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Exam(
                              userID: userID,
                              videoID: videoID,
                              type: type,
                              subjectName: subjectName,
                            )));
              },
              context: context,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );

Widget startExam(context, String text1, String text2) => AlertDialog(
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
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            defaultButton(
              color: Colors.green,
              text: "Enter Live",
              onpressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LiveComments()));
              },
              context: context,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );

Widget findFriends(context, String text1, String text2, List<friend> friends) => AlertDialog(
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
          SizedBox(
            width: 400,
            height: 200,
            child: ListView.builder(
                itemCount: friends.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: (Platform.I.operatingSystem.isAndroid || Platform.I.operatingSystem.isIOS)
                        ? friendCard(
                        context,
                        friends[index].name,
                        friends[index].imageURL,
                        friends[index].number,
                        friends[index].idToEdit,
                        2)
                    : webfriendCard(
                            context,
                            friends[index].name,
                            friends[index].imageURL,
                            friends[index].number,
                            friends[index].idToEdit,
                            2)
                        ,
                  );
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
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
              },
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );

Widget recievedCall(context, String name, String callerID) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: Column(
        children: [
          Text(
            "$name want to start a room with You",
            style: GoogleFonts.rubik(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            "Accept.... ??",
            style: GoogleFonts.rubik(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (Platform.I.operatingSystem.isAndroid || Platform.I.operatingSystem.isIOS)
                ? defaultButton(
              context: context,
              color: Colors.white70,
              textColor: Colors.black,
              text: LocaleKeys.cancel.tr(),
              onpressed: () {
                Navigator.pop(context);

                FlutterRingtonePlayer.stop();

                //wa a8yar al value bta3t caller
              },
            )
            : webdefaultButton(
                    context: context,
                    color: Colors.white70,
                    textColor: Colors.black,
                    text: LocaleKeys.cancel.tr(),
                    onpressed: () {
                      Navigator.pop(context);

                      FlutterRingtonePlayer.stop();

                      //wa a8yar al value bta3t caller
                    },
                  ),
            (Platform.I.operatingSystem.isAndroid || Platform.I.operatingSystem.isIOS)
                ? defaultButton(
              context: context,
              color: Colors.white70,
              textColor: Colors.black,
              text: "Accept",
              onpressed: () async {
                FlutterRingtonePlayer.stop();

                if (await checkConnectionn()) {
                  loading(context: context);

                  FirebaseFirestore.instance
                      .collection('students')
                      .doc(callerID)
                      .update({
                    'call': 3,
                    'callerID': FirebaseAuth.instance.currentUser!.uid,
                  }).then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignIn()));
                  }).catchError((error) {
                    showToast("Failed to add: $error");
                    print("Failed to add: $error");
                  });
                } else {
                  showToast("Check Internet Connection !");
                }
              },
            )
            : webdefaultButton(
                    context: context,
                    color: Colors.white70,
                    textColor: Colors.black,
                    text: "Accept",
                    onpressed: () async {
                      FlutterRingtonePlayer.stop();

                      if (await checkConnectionn()) {
                        loading(context: context);

                        FirebaseFirestore.instance
                            .collection('students')
                            .doc(callerID)
                            .update({
                          'call': 3,
                          'callerID': FirebaseAuth.instance.currentUser!.uid,
                        }).then((value) {
                          Navigator.pop(context);
                          Navigator.pop(context);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignIn()));
                        }).catchError((error) {
                          showToast("Failed to add: $error");
                          print("Failed to add: $error");
                        });
                      } else {
                        showToast("Check Internet Connection !");
                      }
                    },
                  ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );

Widget callingg(context, String text1, String text2, int type) => AlertDialog(
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
            "",
            style: GoogleFonts.rubik(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
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
              text: "Hang Up",
              onpressed: () async {
                if (await checkConnectionn()) {
                  FirebaseFirestore.instance
                      .collection('students')
                      .doc(text2)
                      .update({
                    'call': 0,
                  }).then((value) {
                    Navigator.pop(context);
                  }).catchError((error) {
                    showToast("Failed to add: $error");
                    print("Failed to add: $error");
                  });
                } else {
                  showToast("Check Internet Connection !");
                }
              },
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );


