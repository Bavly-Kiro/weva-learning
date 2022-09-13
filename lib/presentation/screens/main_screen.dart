import 'dart:developer';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weva/cubit/main_cubit/main_cubit_bloc.dart';
import 'package:weva/cubit/main_cubit/main_cubit_state.dart';

import '../../translations/locale_keys.g.dart';
import 'Screen11_drawer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String name = "";

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
    });

    log("444444444444");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubitBloc(),
        child: BlocConsumer<MainCubitBloc, MainCubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            MainCubitBloc cubit = MainCubitBloc.get(context);
            if (kIsWeb) {
              return Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: Color(0XFFe4f1f8),
                  appBar: AppBar(
                    backgroundColor: Color(0XFFe4f1f8),
                    elevation: 0,
                    title: cubit.currentIndex == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                LocaleKeys.what_do_you.tr(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            cubit.screensNames[cubit.currentIndex],
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    leading: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ),
                  drawer: const Drawer11(),
                  body: cubit.screens[cubit.currentIndex],
                  bottomNavigationBar: BottomNavyBar(
                    mainAxisAlignment: MainAxisAlignment.center,
                    selectedIndex: cubit.currentIndex,
                    showElevation: false,
                    onItemSelected: (index) {
                      cubit.changeIndex(index);
                    },
                    items: [
                      BottomNavyBarItem(
                        textAlign: TextAlign.center,
                        icon: Icon(
                          CupertinoIcons.home,
                          color: cubit.currentIndex == 0
                              ? Colors.blue
                              : Colors.black,
                        ),
                        title: Text('Home'),
                        activeColor: Colors.blue,
                      ),
                      BottomNavyBarItem(
                        textAlign: TextAlign.center,
                        icon: Icon(
                          CupertinoIcons.minus_circled,
                          color: cubit.currentIndex == 1
                              ? Colors.blue
                              : Colors.black,
                        ),
                        title: Text('Score'),
                        activeColor: Colors.blue,
                      ),
                      BottomNavyBarItem(
                          textAlign: TextAlign.center,
                          icon: Icon(
                            Icons.people_outline,
                            color: cubit.currentIndex == 2
                                ? Colors.blue
                                : Colors.black,
                          ),
                          title: Text('Friends'),
                          activeColor: Colors.blue
                      ),
                      BottomNavyBarItem(
                          textAlign: TextAlign.center,
                          icon: Icon(
                            CupertinoIcons.person,
                            color: cubit.currentIndex == 3
                                ? Colors.blue
                                : Colors.black,
                          ),
                          title: Text('Profile'),
                          activeColor: Colors.blue),
                    ],
                  ));
            } else {
              return Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: Color(0XFFe4f1f8),
                  appBar: AppBar(
                    backgroundColor: Color(0XFFe4f1f8),
                    elevation: 0,
                    title: cubit.currentIndex == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                LocaleKeys.what_do_you.tr(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            cubit.screensNames[cubit.currentIndex],
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    leading: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ),
                  drawer: const Drawer11(),
                  body: cubit.screens[cubit.currentIndex],
                  bottomNavigationBar: BottomNavyBar(
                    selectedIndex: cubit.currentIndex,
                    showElevation: false,
                    onItemSelected: (index) {
                      cubit.changeIndex(index);
                    },
                    items: [
                      BottomNavyBarItem(
                        icon: Icon(
                          CupertinoIcons.home,
                          color: cubit.currentIndex == 0
                              ? Colors.blue
                              : Colors.black,
                        ),
                        title: Text('Home'),
                        activeColor: Colors.blue,
                      ),
                      BottomNavyBarItem(
                        icon: Icon(
                          CupertinoIcons.minus_circled,
                          color: cubit.currentIndex == 1
                              ? Colors.blue
                              : Colors.black,
                        ),
                        title: Text('Score'),
                        activeColor: Colors.blue,
                      ),
                      BottomNavyBarItem(
                          icon: Icon(
                            Icons.people_outline,
                            color: cubit.currentIndex == 2
                                ? Colors.blue
                                : Colors.black,
                          ),
                          title: Text('Friends'),
                          activeColor: Colors.blue),
                      BottomNavyBarItem(
                          icon: Icon(
                            CupertinoIcons.person,
                            color: cubit.currentIndex == 3
                                ? Colors.blue
                                : Colors.black,
                          ),
                          title: Text('Profile'),
                          activeColor: Colors.blue),
                    ],
                  ));
            }
          },
        ));
  }
}
