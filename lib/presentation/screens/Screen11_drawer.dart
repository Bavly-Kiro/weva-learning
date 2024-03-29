import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:platform_info/platform_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weva/cubit/drawer_cubit/drawer_cubit_state.dart';
import 'package:weva/presentation/screens/home_screen.dart';

import '../../back/checkConnection.dart';
import '../../cubit/drawer_cubit/drawer_cubit_bloc.dart';
import '../../translations/locale_keys.g.dart';
import '../widgets/drawer_row.dart';
import '../widgets/profile_widget.dart';
import '45_choose_level.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Drawer11 extends StatefulWidget {
  const Drawer11({Key? key}) : super(key: key);

  @override
  State<Drawer11> createState() => _Drawer11State();
}

class _Drawer11State extends State<Drawer11> {
  String name = "";
  String email = "";
  String url = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readData();
  }

  void readData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString('name') ?? "";
      email = prefs.getString('email') ?? "";
      url = prefs.getString('url') ?? "";
    });

    log("444444444444");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerCubitBloc(),
      child: BlocConsumer<DrawerCubitBloc, DrawerCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          DrawerCubitBloc drawerCubitBloc = DrawerCubitBloc.get(context);
          if(Platform.I.operatingSystem.isAndroid || Platform.I.operatingSystem.isIOS){
            return SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04,
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profileWidget(
                          context: context,
                          image: AssetImage("assets/images/Group 624543.png"),
                          name: name,
                          email: email),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      drawerRow(
                          context: context,
                          icon: Icons.dashboard_outlined,
                          title: LocaleKeys.dashboard.tr(),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                          }),
                      drawerRow(
                          context: context,
                          icon: Icons.local_offer_outlined,
                          title: LocaleKeys.offers.tr(),
                          onTap: () {}),
                      drawerRow(
                          context: context,
                          icon: Icons.payments_outlined,
                          title: LocaleKeys.payments.tr(),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChooseLevel()));
                          }),
                      drawerRow(
                          context: context,
                          icon: Icons.settings_outlined,
                          title: LocaleKeys.settings.tr(),
                          onTap: () {}),
                      /*Row(
                      children: [
                        Icon(
                          drawerCubitBloc.isDark
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          size: MediaQuery.of(context).size.width * 0.08,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        CupertinoSwitch(
                          value: drawerCubitBloc.isDark,
                          onChanged: (value) {
                            drawerCubitBloc.changeTheme(value);
                          },
                          trackColor: Colors.grey.shade400,
                          activeColor: Colors.grey.shade400,
                        )
                      ],
                    ),*/
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width * 0.5,
                            color: Colors.black,
                          ),
                          drawerRow(
                              context: context,
                              icon: Icons.help_outline,
                              title: LocaleKeys.about_us.tr(),
                              onTap: () {}),
                          drawerRow(
                              context: context,
                              icon: Icons.call_outlined,
                              title: LocaleKeys.support.tr(),
                              onTap: () {}),
                          drawerRow(
                              context: context,
                              icon: Icons.logout,
                              title: LocaleKeys.log_out.tr(),
                              onTap: () async {
                                log("tapped");

                                if (await checkConnectionn()) {
                                  showToast("logging out...");

                                  await FirebaseAuth.instance.signOut();
                                } else {
                                  showToast("Check Internet Connection !");
                                }
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          else {
            return SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.07,
                      left: MediaQuery.of(context).size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      webprofileWidget(
                          context: context,
                          image: AssetImage("assets/images/Group 624543.png"),
                          name: name,
                          email: email),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      webdrawerRow(
                          context: context,
                          icon: Icons.dashboard_outlined,
                          title: LocaleKeys.dashboard.tr(),
                          onTap: () {}),
                      webdrawerRow(
                          context: context,
                          icon: Icons.local_offer_outlined,
                          title: LocaleKeys.offers.tr(),
                          onTap: () {}),
                      webdrawerRow(
                          context: context,
                          icon: Icons.payments_outlined,
                          title: LocaleKeys.payments.tr(),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChooseLevel()));
                          }),
                      webdrawerRow(
                          context: context,
                          icon: Icons.settings_outlined,
                          title: LocaleKeys.settings.tr(),
                          onTap: () {}),
                      /*Row(
                      children: [
                        Icon(
                          drawerCubitBloc.isDark
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          size: MediaQuery.of(context).size.width * 0.08,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        CupertinoSwitch(
                          value: drawerCubitBloc.isDark,
                          onChanged: (value) {
                            drawerCubitBloc.changeTheme(value);
                          },
                          trackColor: Colors.grey.shade400,
                          activeColor: Colors.grey.shade400,
                        )
                      ],
                    ),*/
                      Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Colors.black,
                            ),
                            webdrawerRow(
                                context: context,
                                icon: Icons.help_outline,
                                title: LocaleKeys.about_us.tr(),
                                onTap: () {}),
                            webdrawerRow(
                                context: context,
                                icon: Icons.call_outlined,
                                title: LocaleKeys.support.tr(),
                                onTap: () {}),
                            webdrawerRow(
                                context: context,
                                icon: Icons.logout,
                                title: LocaleKeys.log_out.tr(),
                                onTap: () async {
                                  log("tapped");

                                  if (await checkConnectionn()) {
                                    showToast("logging out...");

                                    await FirebaseAuth.instance.signOut();
                                  } else {
                                    showToast("Check Internet Connection !");
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
