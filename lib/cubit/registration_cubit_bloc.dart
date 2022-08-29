import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:weva/cubit/registration_cubit_state.dart';

import '../back/checkConnection.dart';

import 'package:google_sign_in/google_sign_in.dart';
import '../../translations/locale_keys.g.dart';
import '../presentation/screens/3_personal_infotmation.dart';

class RegistrationCubitBloc extends Cubit<RegistrationCubitState> {
  RegistrationCubitBloc() : super(RegistrationCubitInitial()) {}

  static RegistrationCubitBloc get(context) => BlocProvider.of(context);

  void SignUpWithFacebook(BuildContext context) async{

    if(await checkConnectionn()){

      showToast("Logging In....");

      try {



      } on FirebaseAuthException catch (e) {

        if (e.code == 'wrong-password') {



        }
      }


    }else{

      showToast("Check Internet Connection !");

    }

  }

  void SignUpWithGoogle(BuildContext context) async{

    if(await checkConnectionn()){

      showToast(LocaleKeys.login_point.tr());

      try {


          // Trigger the authentication flow
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

          // Obtain the auth details from the request
          final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          // Once signed in, return the UserCredential
           log(await FirebaseAuth.instance.signInWithCredential(credential).toString());

      } on FirebaseAuthException catch (e) {

        log(e.toString());

        if (e.code == 'wrong-password') {



        }
      }


    }else{

      showToast("Check Internet Connection !");

    }

  }

  void SignUpWithEmail(BuildContext context) {

    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PersonalInformation()));

  }

  void Continue() {}
}
