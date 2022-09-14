import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/screens/1.dart';
import '../presentation/screens/6 sign in.dart';
import '../presentation/screens/Discussion.dart';
import '../presentation/screens/main_screen.dart';
import '../presentation/widgets/alert_dialog.dart';
import 'checkConnection.dart';
import 'loading.dart';
import 'loadingScreen.dart';

import 'package:flutter/foundation.dart' show kIsWeb;


class checkLogin extends StatefulWidget {
  const checkLogin({Key? key}) : super(key: key);

  @override
  State<checkLogin> createState() => _checkLoginState();
}

class _checkLoginState extends State<checkLogin> {

  void checkOnline() async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    Map<String, dynamic> presenceStatusTrue = {
      'presence': true,
      'last_seen': DateTime.now().millisecondsSinceEpoch,
    };

    await databaseReference
        .child(FirebaseAuth.instance.currentUser!.uid)
        .update(presenceStatusTrue)
        .whenComplete(() {

/*      FirebaseFirestore.instance
          .collection('students')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'online': 1,
      }).then((value) {
        log('checkLogin 1 Updated your presence.');
      }).catchError((error) {
        showToast("Failed to online: $error");
        log("Failed to add: $error");
      });*/

    }).catchError((e) => log(e));

    Map<String, dynamic> presenceStatusFalse = {
      'presence': false,
      'last_seen': DateTime.now().millisecondsSinceEpoch,
    };

    sub2 = databaseReference
        .child(FirebaseAuth.instance.currentUser!.uid)
        .onDisconnect()
        .update(presenceStatusFalse)
        .then((value) {

/*      FirebaseFirestore.instance
          .collection('students')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'online': 0,
      }).then((value) {
        log('checkLogin 2 Updated your presence.');
      }).catchError((error) {
        showToast("Failed to online: $error");
        log("Failed to add: $error");
      });*/
    });


    getUserData();
  }

  void getUserData() async {
    if (await checkConnectionn()) {
      loading(context: context);
      log("checkLogin 9");

      FirebaseFirestore.instance
          .collection('students')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(const GetOptions(source: Source.server))
          .then((value) async {
        //name = value.get("name");
        //email = value.get("email");
        //url = value.get("imageURL");

        final prefs = await SharedPreferences.getInstance();

        prefs.setString('name', value.get("name"));
        prefs.setString('email', value.get("email"));
        prefs.setString('url', value.get("imageURL"));

        log("checkLogin 5555555555555555555555555");

        Navigator.of(context).pop();
        log("checkLogin 10");

        listenToCalls();

      }).onError((error, stackTrace) {
        log("checkLogin $error");
        showToast("checkLogin Error: $error");
      });
    } else {
      showToast("Check Internet Connection !");
    }
  }

  //1 ringing
  //2 msh8ol (y3ny gwa al room)

  var sub1;
  var sub2;

  void listenToCalls() {
    sub1 = FirebaseFirestore.instance
        .collection('students')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      //print(snapshot.data());
      if (snapshot.exists) {
        if (snapshot.data()!['call'] == 1) {
          //ringing


          FirebaseFirestore.instance.collection('students').doc(FirebaseAuth.instance.currentUser!.uid).update({
            'online': 1,

          })
              .then((value) {

            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return recievedCall(
                      context, "تيست 2", snapshot.data()!['callerID']);
                });

          })
              .catchError((error) {

            showToast("Failed to add: $error");
            print("Failed to add: $error");

          });


          if(!kIsWeb){

            FlutterRingtonePlayer.play(
              android: AndroidSounds.ringtone,
              ios: IosSounds.electronic,
              looping: true, // Android only - API >= 28
              asAlarm: false, // Android only - all APIs
            );

          }




        }
        else if (snapshot.data()!['call'] == 3) {

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Discussion()));

        } else {

          if(!kIsWeb) {
            FlutterRingtonePlayer.stop();
          }

        }
      }
    });
  }



  int counter = 0;

  @override
  void dispose() {
    super.dispose();
    sub1?.cancel();
    sub2?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, userSnapshot) {

          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return loadingScreen();
          }

          if (!userSnapshot.hasData) {

              counter = 0;

              log("check login doesn't has Data");

             // sub1?.cancel();
             // sub2?.cancel();

            return Screen1();

          }
          else if (userSnapshot.hasData) {

            if(counter == 0){
              counter++;

              checkOnline();


              log("check login has Data");

            }


            return MainScreen();
          }
          else if (userSnapshot.hasError) {
            return const Center(
              child: Text(
                'The app error',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text(
                'something Went Wrong',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          );
        });
  }
}
