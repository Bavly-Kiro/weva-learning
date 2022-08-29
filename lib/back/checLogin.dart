import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/screens/1.dart';
import '../presentation/screens/main_screen.dart';
import 'checkConnection.dart';
import 'loading.dart';
import 'loadingScreen.dart';


class checkLogin extends StatefulWidget {
  const checkLogin({Key? key}) : super(key: key);

  @override
  State<checkLogin> createState() => _checkLoginState();
}

class _checkLoginState extends State<checkLogin> {


  void checkOnline() async{

    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

      Map<String, dynamic> presenceStatusTrue = {
        'presence': true,
        'last_seen': DateTime.now().millisecondsSinceEpoch,
      };

      await databaseReference
          .child(FirebaseAuth.instance.currentUser!.uid)
          .update(presenceStatusTrue)
          .whenComplete(() {

              FirebaseFirestore.instance.collection('students').doc(FirebaseAuth.instance.currentUser!.uid).update({
                'online': 1,
              })
                  .then((value) {
                 log('Updated your presence.');
              })
                  .catchError((error) {

                showToast("Failed to online: $error");
                log("Failed to add: $error");

              });


          })
          .catchError((e) => log(e));

      Map<String, dynamic> presenceStatusFalse = {
        'presence': false,
        'last_seen': DateTime.now().millisecondsSinceEpoch,
      };

      databaseReference.child(FirebaseAuth.instance.currentUser!.uid).onDisconnect().update(presenceStatusFalse).then((value) {

        FirebaseFirestore.instance.collection('students').doc(FirebaseAuth.instance.currentUser!.uid).update({
          'online': 0,
        })
            .then((value) {
          log('Updated your presence.');
        })
            .catchError((error) {

          showToast("Failed to online: $error");
          log("Failed to add: $error");

        });

      });


      getUserData();

  }


  void getUserData() async{

    if(await checkConnectionn()){

      loading(context: context);

      FirebaseFirestore.instance.collection('students').doc(FirebaseAuth.instance.currentUser!.uid).get(const GetOptions(source: Source.server))
          .then((value) async{

        //name = value.get("name");
        //email = value.get("email");
        //url = value.get("imageURL");

        final prefs = await SharedPreferences.getInstance();

        prefs.setString('name', value.get("name"));
        prefs.setString('email', value.get("email"));
        prefs.setString('url', value.get("imageURL"));

        log("5555555555555555555555555");

        Navigator.of(context).pop();

      }).onError((error, stackTrace) {

        log(error.toString());
        showToast("Error: $error");

      });

    }
    else{

      showToast("Check Internet Connection !");

    }

  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context,userSnapshot){

          if(userSnapshot.connectionState == ConnectionState.waiting){

            return loadingScreen();
          }

          if(!userSnapshot.hasData){
            return Screen1();
          }
          else if(userSnapshot.hasData){

            checkOnline();

            return MainScreen();
          }
          else if(userSnapshot.hasError){
            return const Center(
              child: Text('The app error',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
            );
          }
          return const Scaffold(
            body:  Center(
              child: Text('something Went Wrong',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
            ),
          );
        });
  }
}

/*

@override
Widget build(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,userSnapshot){
        if(!userSnapshot.hasData){
          return const LoginScreen();
        }
        else if(userSnapshot.hasData){
          return TasksScreen();
        }
        else if(userSnapshot.hasError){
          return const Center(
            child: Text('The app error',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
          );
        }
        return const Scaffold(
          body:  Center(
            child: Text('something Want',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
          ),
        );
      });
}

void checkLoginn({required BuildContext context}){

  if(context == null){

  }else{
  contextt = context;
  }

  FirebaseAuth.instance
      .userChanges()
      .listen((User? user) {
    if (user == null) {
      Navigator.pushReplacement(contextt, MaterialPageRoute(builder: (context)=>LoginScreen()));
    } else {
      Navigator.pushReplacement(contextt, MaterialPageRoute(builder: (context)=>HomePanelScreen()));
    }
  });



*/
/*  final prefs = await SharedPreferences.getInstance();

  String email = prefs.getString('email') ?? "";

  if(email.isEmpty) {
    //not logged

    return false;
  }else{

    return true;
  }*/
/*


}*/
