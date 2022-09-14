import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_info/platform_info.dart';
import 'package:weva/cubit/registration_cubit_bloc.dart';
import 'package:weva/cubit/registration_cubit_state.dart';

import '../../translations/locale_keys.g.dart';
import '../widgets/cerved_container.dart';
import '../widgets/registration_button.dart';
import '6 sign in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => RegistrationCubitBloc(),
        child: BlocConsumer<RegistrationCubitBloc, RegistrationCubitState>(
          listener: (BuildContext context, RegistrationCubitState state) {},
          builder: (BuildContext context, RegistrationCubitState state) {
            RegistrationCubitBloc cub = RegistrationCubitBloc.get(context);
            if(Platform.I.operatingSystem.isAndroid || Platform.I.operatingSystem.isIOS){
              return Scaffold(
                  backgroundColor: const Color(0XFFe4f1f8),
                  body: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          cervedContainer(context: context),
                          SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.21,
                                      ),
                                      const Image(
                                        image: AssetImage(
                                            "assets/images/Group 624543.png"),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                registrationButton(
                                  text: LocaleKeys.sign_up_face.tr(),
                                  context: context,
                                  imagePath: 'assets/images/Facebook F.png',
                                  color: const Color(0XFFe35f60),
                                  onTap: () {
                                    cub.SignUpWithFacebook(context);
                                  },
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.05,
                                ),
                                registrationButton(
                                  text: LocaleKeys.sign_up_google.tr(),
                                  context: context,
                                  imagePath: 'assets/images/Google.png',
                                  color: const Color(0XFF868686),
                                  onTap: () {
                                    cub.SignUpWithGoogle(context);
                                  },
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.05,
                                  child: Text(
                                    LocaleKeys.or.tr(),
                                    style: const TextStyle(
                                      color: Color(0XFF3f3f3f),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                registrationButton(
                                  text: LocaleKeys.sign_up_email.tr(),
                                  context: context,
                                  onTap: () {
                                    cub.SignUpWithEmail(context);
                                  },
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(LocaleKeys.already_have_acc.tr(),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: Color(0XFF3f3f3f))),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignIn()));
                                      },
                                      child: Text(LocaleKeys.sign_in.tr(),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.blueAccent)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )));
            }
            else{
              return Scaffold(
                  backgroundColor: const Color(0XFFe4f1f8),
                  body: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          cervedContainer(context: context),
                          SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.21,
                                      ),
                                      const Image(
                                        image: AssetImage(
                                            "assets/images/Group 624543.png"),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                webregistrationButton(
                                  text: LocaleKeys.sign_up_face.tr(),
                                  context: context,
                                  imagePath: 'assets/images/Facebook F.png',
                                  color: const Color(0XFFe35f60),
                                  onTap: () {
                                    cub.SignUpWithFacebook(context);
                                  },
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.05,
                                ),
                                webregistrationButton(
                                  text: LocaleKeys.sign_up_google.tr(),
                                  context: context,
                                  imagePath: 'assets/images/Google.png',
                                  color: const Color(0XFF868686),
                                  onTap: () {
                                    cub.SignUpWithGoogle(context);
                                  },
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.05,
                                  child: Text(
                                    LocaleKeys.or.tr(),
                                    style: const TextStyle(
                                      color: Color(0XFF3f3f3f),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                webregistrationButton(
                                  text: LocaleKeys.sign_up_email.tr(),
                                  context: context,
                                  onTap: () {
                                    cub.SignUpWithEmail(context);
                                  },
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(LocaleKeys.already_have_acc.tr(),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: Color(0XFF3f3f3f))),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignIn()));
                                      },
                                      child: Text(LocaleKeys.sign_in.tr(),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.blueAccent)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.03,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )));
            }
          },
        ));
  }
}
