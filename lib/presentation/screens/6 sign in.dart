import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:oktoast/oktoast.dart';
import 'package:platform_info/platform_info.dart';
import 'package:weva/presentation/screens/main_screen.dart';
import 'package:weva/presentation/widgets/default_text_button.dart';

import '../../back/checkConnection.dart';
import '../../translations/locale_keys.g.dart';
import '../widgets/aTXTFld.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/cerved_container.dart';
import '../widgets/registration_button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

// ignore_for_file: prefer_const_constructors
class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

bool isPassword = true;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    if(Platform.I.operatingSystem.isAndroid || Platform.I.operatingSystem.isIOS){
      return Scaffold(
          backgroundColor: const Color(0XFFe4f1f8),
          body: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    cervedContainer(context: context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.14,
                          ),
                          Image(
                            image: AssetImage("assets/images/signin.png"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          registrationButton(
                            text: LocaleKeys.sign_in_face.tr(),
                            context: context,
                            imagePath: 'assets/images/Facebook F.png',
                            color: Color(0XFFe35f60),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          registrationButton(
                            text: LocaleKeys.sign_in_google.tr(),
                            context: context,
                            imagePath: 'assets/images/Google.png',
                            color: const Color(0XFF868686),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            LocaleKeys.or.tr(),
                            style: TextStyle(
                              color: Color(0XFF3f3f3f),
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          TxtFld(
                            controller: emailController,
                            label: LocaleKeys.email.tr(),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          TxtFld(
                            sicon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                              icon: Icon(
                                isPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility_rounded,
                                color: Colors.grey,
                              ),
                            ),
                            controller: passwordController,
                            label: LocaleKeys.pass.tr(),
                            isPassword: isPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'empty field required';
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /*defaultTextButton(
                                color: Color(0xff3f3f3f),
                                text: LocaleKeys.forget_pass.tr(),
                                onpressed: () {})*/
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                              ),
                            ],
                          ),
                          registrationButton(
                            text: LocaleKeys.sign_in.tr(),
                            context: context,
                            onTap: () async {
                              if (await checkConnectionn()) {
                                showToast("Logging In....");

                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                      .then((value) {

                                    /*Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreen()));*/

                                    if(kIsWeb){
                                      html.window.location.reload();
                                    }else{
                                      // a8yarha wa7shaa
                                      Phoenix.rebirth(context);
                                    }


                                  });
                                } on FirebaseAuthException catch (e) {
                                  //here

                                  if (e.code == 'wrong-password') {
                                    //Navigator.of(context).pop();

                                    // set up the button
                                    Widget okButton = TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    );

                                    // set up the AlertDialog
                                    AlertDialog alert = AlertDialog(
                                      title: const Text("Wrong Password"),
                                      content: const Text(
                                          "please check your Password"),
                                      actions: [
                                        okButton,
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  } else {
                                    //Navigator.of(context).pop();

                                    // set up the button
                                    Widget okButton = TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    );

                                    // set up the AlertDialog
                                    AlertDialog alert = AlertDialog(
                                      title: const Text("Wrong Email"),
                                      content:
                                      const Text("please check your email"),
                                      actions: [
                                        okButton,
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  }
                                }
                              } else {
                                //showToast("Check Internet Connection !");

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
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ));
    }
    else {
      return Scaffold(
          backgroundColor: const Color(0XFFe4f1f8),
          body: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    cervedContainer(context: context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.14,
                          ),
                          Image(
                            image: AssetImage("assets/images/signin.png"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          webregistrationButton(
                            text: LocaleKeys.sign_in_face.tr(),
                            context: context,
                            imagePath: 'assets/images/Facebook F.png',
                            color: Color(0XFFe35f60),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          webregistrationButton(
                            text: LocaleKeys.sign_in_google.tr(),
                            context: context,
                            imagePath: 'assets/images/Google.png',
                            color: const Color(0XFF868686),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            LocaleKeys.or.tr(),
                            style: TextStyle(
                              color: Color(0XFF3f3f3f),
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          webTxtFld(
                            controller: emailController,
                            label: LocaleKeys.email.tr(),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            context: context,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          webTxtFld(
                            context: context,
                            sicon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                              icon: Icon(
                                isPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility_rounded,
                                color: Colors.grey,
                              ),
                            ),
                            controller: passwordController,
                            label: LocaleKeys.pass.tr(),
                            isPassword: isPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'empty field required';
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /*defaultTextButton(
                                color: Color(0xff3f3f3f),
                                text: LocaleKeys.forget_pass.tr(),
                                onpressed: () {})*/
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                            ],
                          ),
                          webregistrationButton(
                            text: LocaleKeys.sign_in.tr(),
                            context: context,
                            onTap: () async {
                              if (await checkConnectionn()) {
                                showToast("Logging In....");

                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((value) {
                                    /*Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreen()));*/

                                    if(kIsWeb){
                                      html.window.location.reload();
                                    }else{
                                      // a8yarha wa7shaa
                                      Phoenix.rebirth(context);
                                    }


                                  });
                                } on FirebaseAuthException catch (e) {
                                  //here

                                  if (e.code == 'wrong-password') {
                                    //Navigator.of(context).pop();

                                    // set up the button
                                    Widget okButton = TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    );

                                    // set up the AlertDialog
                                    AlertDialog alert = AlertDialog(
                                      title: const Text("Wrong Password"),
                                      content: const Text(
                                          "please check your Password"),
                                      actions: [
                                        okButton,
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  } else {
                                    //Navigator.of(context).pop();

                                    // set up the button
                                    Widget okButton = TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    );

                                    // set up the AlertDialog
                                    AlertDialog alert = AlertDialog(
                                      title: const Text("Wrong Email"),
                                      content:
                                          const Text("please check your email"),
                                      actions: [
                                        okButton,
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  }
                                }
                              } else {
                                //showToast("Check Internet Connection !");

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
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ));
    }
  }
}
