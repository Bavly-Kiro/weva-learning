import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weva/presentation/widgets/score_stack.dart';

import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../../back/models/levels.dart';
import '../../back/models/subject.dart';
import '../../constants.dart';
import '../../cubit/home_cubit/home_cubit_bloc.dart';
import '../../cubit/home_cubit/home_cubit_state.dart';
import '../../translations/locale_keys.g.dart';
import '../widgets/aTXTFld.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/catecory_card.dart';
import '../widgets/default_button.dart';
import '../widgets/dropdown_textField.dart';
import '../widgets/game_card.dart';
import '12_chapter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:platform_info/platform_info.dart' as Platformm;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  String name = "";
  String email = "";
  String url = "";
  String gradeID = "";

  String subName = "";
  int rightAns = 0;
  int totalAns = 0;
  double lastTestPercentage = 0;


  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getChapters();
    //
    Selectedvalue1 = null;
    Selectedvalue2 = null;
    getUserData();
  }

  List<lesson> lessons = [];
  List<String> lessonss = [];
  //
  // List<chapter> chapters = [];
  // List<String> chapterss = [];

  //
  // void getChapters(subjectID) async{
  //
  //   chapters = [];
  //   chapterss = [];
  //
  //   if(await checkConnectionn()){
  //
  //     loading(context: context);
  //
  //     FirebaseFirestore.instance.collection('chapters').where("subjectID", isEqualTo: widget.subjectID).get(const GetOptions(source: Source.server))
  //         .then((value) {
  //
  //
  //       final List<chapter> loadData = [];
  //
  //       for (var element in value.docs) {
  //         //element.data();
  //         //log(element.data()['nameAr'].toString());
  //
  //         loadData.add(chapter(
  //           idToEdit: element.id,
  //           nameAr: element.data()['nameAr'] ?? "",
  //           nameEN: element.data()['nameEN'] ?? "",
  //           subjectID: element.data()['subjectID'] ?? "",
  //           mrID: element.data()['mrID'] ?? "",
  //           chNum: element.data()['chNum'] ?? "",
  //
  //           userDoneAction: element.data()['userDoneAction'] ?? "",
  //           LastUserDoneAction: element.data()['LastUserDoneAction'] ?? "",
  //           status: element.data()['status'] ?? "",
  //
  //         ));
  //
  //         chapterss.add(Localizations.localeOf(context).toString() == "en" ? element.data()['nameEN'] : element.data()['nameAr']);
  //
  //       }
  //
  //       //loadData.sort((a, b) => a.chNum.compareTo(b.chNum));
  //
  //       setState(() {
  //         chapters = loadData;
  //       });
  //
  //       Navigator.of(context).pop();
  //
  //       //getLessons();
  //
  //     }).onError((error, stackTrace) {
  //
  //       log(error.toString());
  //       showToast("Error: $error");
  //
  //     });
  //
  //   }else{
  //
  //     showToast("Check Internet Connection !");
  //
  //   }
  //
  // }
  //
  //
  // List<lesson> lessons = [];
  // List<String> lessonss = [];
  //
  // void getLessons(chapterID) async{
  //
  //   lessons = [];
  //   lessonss = [];
  //
  //   if(await checkConnectionn()){
  //
  //     loading(context: context);
  //
  //     FirebaseFirestore.instance.collection('lessons').where("chapterID", isEqualTo: chapterID).get(const GetOptions(source: Source.server))
  //         .then((value) {
  //
  //
  //       final List<lesson> loadData = [];
  //
  //       for (var element in value.docs) {
  //         //element.data();
  //         //log(element.data()['nameAr'].toString());
  //
  //         loadData.add(lesson(
  //           idToEdit: element.id,
  //           nameAr: element.data()['nameAr'] ?? "",
  //           nameEN: element.data()['nameEN'] ?? "",
  //           subjectID: element.data()['subjectID'] ?? "",
  //           chapterID: element.data()['chapterID'] ?? "",
  //           mrID: element.data()['mrID'] ?? "",
  //           lessNum: element.data()['lessNum'] ?? "",
  //
  //           userDoneAction: element.data()['userDoneAction'] ?? "",
  //           LastUserDoneAction: element.data()['LastUserDoneAction'] ?? "",
  //           status: element.data()['status'] ?? "",
  //
  //         ));
  //
  //         lessonss.add(Localizations.localeOf(context).toString() == "en" ? element.data()['nameEN'] : element.data()['nameAr']);
  //
  //       }
  //
  //       //loadData.sort((a, b) => a.lessNum.compareTo(b.lessNum));
  //
  //       setState(() {
  //         lessons = loadData;
  //       });
  //
  //       Navigator.of(context).pop();
  //
  //     }).onError((error, stackTrace) {
  //
  //       log(error.toString());
  //       showToast("Error: $error");
  //
  //     });
  //
  //   }else{
  //
  //     showToast("Check Internet Connection !");
  //
  //   }
  //
  // }

  String value = "";

  Future<void> getUserData() async {
    if (await checkConnectionn()) {
      loading(context: context);

      FirebaseFirestore.instance
          .collection('students')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(const GetOptions(source: Source.server))
          .then((value) async {
        name = value.get("name");
        email = value.get("email");
        url = value.get("imageURL");
        gradeID = value.get("gradeID");

        final prefs = await SharedPreferences.getInstance();

        prefs.setString('name', value.get("name"));
        prefs.setString('email', value.get("email"));
        prefs.setString('url', value.get("imageURL"));
        prefs.setString('gradeID', value.get("gradeID"));

        FirebaseFirestore.instance
            .collection('lastTestScore')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(const GetOptions(source: Source.server))
            .then((valuee) async {
          if (valuee.exists) {
            log("home exist");

            setState(() {
              subName = valuee.get("subjectName") ?? "";
              rightAns = valuee.get("rightAns") ?? 0;
              totalAns = valuee.get("totalAns") ?? 0;
              lastTestPercentage = 100 * (rightAns) / (totalAns);
            });
          }

          getSubjects();
        }).onError((error, stackTrace) {
          log("home 1 $error");
          showToast("Error: $error");
        });
      }).onError((error, stackTrace) {
        log("home 2 $error");
        showToast("Error: $error");
      });
    } else {
      showToast("Check Internet Connection !");
    }
  }

  List<subject> subjects = [];

  void getSubjects() async {
    subjects = [];

    if(mounted){
      if (await checkConnectionn()) {
        log("home 3 1");
        FirebaseFirestore.instance
            .collection('subjects')
            .where("gradeID", isEqualTo: gradeID)
            .get(const GetOptions(source: Source.server))
            .then((value) {
          final List<subject> loadData = [];
          log("home 3 2");

          for (var element in value.docs) {
            loadData.add(subject(
              idToEdit: element.id,
              nameAr: element.data()['nameAr'] ?? "",
              nameEN: element.data()['nameEN'] ?? "",
              countryID: element.data()['countryID'] ?? "",
              majorID: element.data()['majorID'] ?? "",
              gradeID: element.data()['gradeID'] ?? "",
              typeOfSchoolID: element.data()['typeOfSchoolID'] ?? "",
              teacherID: element.data()['teacherID'] ?? "",
              chaptersPerLevel: element.data()['chaptersPerLevel'] ?? "",
              imageURL: element.data()['imageURL'] ?? "",
              userDoneAction: element.data()['userDoneAction'] ?? "",
              LastUserDoneAction: element.data()['LastUserDoneAction'] ?? "",
              status: element.data()['status'] ?? "",
            ));
          }
          log("home 3 3");

          if (this.mounted) {
            setState(() {
              subjects = loadData;
            });
          }
          log("home 3 4");

          Navigator.of(context).pop();
        }).onError((error, stackTrace) {
          log("home 3 $error");
          print("home 3 $error");
          showToast("Error: $error");
        });
      }
      else {
        showToast("Check Internet Connection !");
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    if(Platformm.Platform.I.operatingSystem.isAndroid || Platformm.Platform.I.operatingSystem.isIOS){
      return RefreshIndicator(
        onRefresh: () => getUserData(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TxtFld(
                    onSubmit: (v) async {
                      if (v.isNotEmpty) {
                        List<friend> friends = [];

                        if (await checkConnectionn()) {
                          loading(context: context);

                          FirebaseFirestore.instance
                              .collection('students')
                              .where("number", isEqualTo: v)
                              .get(const GetOptions(source: Source.server))
                              .then((value) {
                            final List<friend> loadData = [];

                            for (var element in value.docs) {
                              loadData.add(friend(
                                idToEdit: element.id,
                                name: element.data()['name'] ?? "",
                                number: element.data()['number'] ?? "",
                                imageURL: element.data()['imageURL'] ?? "",
                                userID: element.data()['userID'] ?? "",
                                friendID: element.data()['friendID'] ?? "",
                              ));
                            }

                            loadData.sort((a, b) => a.name.compareTo(b.name));

                            setState(() {
                              friends = loadData;
                            });

                            Navigator.of(context).pop();

                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return findFriends(context, "", "", friends);
                                });
                          }).onError((error, stackTrace) {
                            log("home 4 $error");
                            showToast("Error: $error");
                          });
                        } else {
                          showToast("Check Internet Connection !");
                        }
                      }
                    },
                    controller: searchController,
                    label: LocaleKeys.search_num.tr(),
                    picon: Icon(
                      Icons.search,
                      size: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(LocaleKeys.subjects.tr(),
                    style: GoogleFonts.rubik(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      return categoryCard(
                          imagePath: subjects[index].imageURL,
                          title:
                          Localizations.localeOf(context).toString() == "en"
                              ? subjects[index].nameEN
                              : subjects[index].nameAr,
                          context: context,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Chapter(
                                  subjectID: subjects[index].idToEdit,
                                  name: Localizations.localeOf(context)
                                      .toString() ==
                                      "en"
                                      ? subjects[index].nameEN
                                      : subjects[index].nameAr,
                                )));
                          });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(LocaleKeys.new_games.tr(),
                    style: GoogleFonts.rubik(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.50,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      gameCard(
                        imagePath: "assets/images/games/Group 624573.png",
                        discussionTitle: LocaleKeys.discussion.tr(),
                        discussion: LocaleKeys.about_discussion.tr(),
                        context: context,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      gameCard(
                          imagePath: "assets/images/games/Group 20127.png",
                          discussionTitle: LocaleKeys.five_days_chall.tr(),
                          discussion: LocaleKeys.about_5_days_chall.tr(),
                          context: context,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                var height = MediaQuery.of(context).size.height;
                                var width = MediaQuery.of(context).size.width;
                                return Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.45,
                                  child: AlertDialog(
                                    insetPadding: EdgeInsets.symmetric(
                                        horizontal: 200, vertical: 200),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    title: Center(
                                      child: Text('Choose Chapter and lesson'),
                                    ),
                                    content: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        DropDown(
                                          // Selecteditems: [
                                          //   'a7a',
                                          //   'sha5ra',
                                          //   'sha5ra b a7a'
                                          // ],
                                          Selecteditems: lessonss
                                              .map(buildMenuitem)
                                              .toList(),
                                          SelectedValue: Selectedvalue2,
                                          onChanged: (valuee) {
                                            setState(() {
                                              Selectedvalue1 = valuee;
                                              value = valuee;

                                              // log(value);
                                              //
                                              // log(chapters[chapters.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == value)].idToEdit);
                                              //
                                              //
                                              // getLessons(chapters[chapters.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == value)].idToEdit);
                                            });
                                          },
                                          context: context,
                                          hint: 'Chapter',
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.03,
                                        ),
                                        DropDown(
                                          // Selecteditems: [
                                          //   'nfs el a7a',
                                          //   'nfs el sha5ra',
                                          //   'nfs el sha5ra b a7a',
                                          // ],
                                          Selecteditems: lessonss
                                              .map(buildMenuitem)
                                              .toList(),
                                          SelectedValue: Selectedvalue2,
                                          onChanged: (value) {
                                            setState(() {
                                              Selectedvalue2 = value;
                                            });
                                          },
                                          context: context,
                                          hint: 'Lesson',
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          smalldefaultButton(
                                            context: context,
                                            color: Colors.white70,
                                            textColor: Colors.black,
                                            text: LocaleKeys.cancel.tr(),
                                            onpressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03,
                                          ),
                                          smalldefaultButton(
                                            color: dodblue,
                                            text: LocaleKeys.submit.tr(),
                                            onpressed: () {},
                                            context: context,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      gameCard(
                        imagePath: "assets/images/games/Group 624572.png",
                        discussionTitle: LocaleKeys.challenge.tr(),
                        discussion: LocaleKeys.about_chall.tr(),
                        context: context,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                scoreStack(
                  subject: "Subject: $subName",
                  score: LocaleKeys.last_test_score.tr(),
                  context: context,
                  percent: lastTestPercentage.toInt(),
                  foregroundColor: Colors.blue.shade400,
                  direction: Localizations.localeOf(context).toString() == "en"
                      ? Direction.rtl
                      : Direction.ltr,
                  backgroundColor: Colors.blueAccent.shade700,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                scoreStack(
                  subject: "Subject: Math",
                  score: LocaleKeys.last_game_score.tr(),
                  context: context,
                  percent: 42,
                  foregroundColor: Colors.pink.shade300,
                  direction: Localizations.localeOf(context).toString() == "en"
                      ? Direction.rtl
                      : Direction.ltr,
                  backgroundColor: Colors.pink.shade800,
                ),
              ],
            ),
          ),
        ),
      );
    }
    else {
      return RefreshIndicator(
        onRefresh: () => getUserData(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TxtFld(
                  onSubmit: (v) async {
                    if (v.isNotEmpty) {
                      List<friend> friends = [];

                      if (await checkConnectionn()) {
                        loading(context: context);

                        FirebaseFirestore.instance
                            .collection('students')
                            .where("number", isEqualTo: v)
                            .get(const GetOptions(source: Source.server))
                            .then((value) {
                          final List<friend> loadData = [];

                          for (var element in value.docs) {
                            loadData.add(friend(
                              idToEdit: element.id,
                              name: element.data()['name'] ?? "",
                              number: element.data()['number'] ?? "",
                              imageURL: element.data()['imageURL'] ?? "",
                              userID: element.data()['userID'] ?? "",
                              friendID: element.data()['friendID'] ?? "",
                            ));
                          }

                          loadData.sort((a, b) => a.name.compareTo(b.name));

                          setState(() {
                            friends = loadData;
                          });

                          Navigator.of(context).pop();

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return findFriends(context, "", "", friends);
                              });
                        }).onError((error, stackTrace) {
                          log("home 5 $error");
                          showToast("Error: $error");
                        });
                      } else {
                        showToast("Check Internet Connection !");
                      }
                    }
                  },
                  controller: searchController,
                  label: LocaleKeys.search_num.tr(),
                  picon: Icon(
                    Icons.search,
                    size: MediaQuery.of(context).size.width * 0.01,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(LocaleKeys.subjects.tr(),
                    style: GoogleFonts.rubik(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      return webcategoryCard(
                          imagePath: subjects[index].imageURL,
                          title:
                              Localizations.localeOf(context).toString() == "en"
                                  ? subjects[index].nameEN
                                  : subjects[index].nameAr,
                          context: context,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Chapter(
                                      subjectID: subjects[index].idToEdit,
                                      name: Localizations.localeOf(context)
                                                  .toString() ==
                                              "en"
                                          ? subjects[index].nameEN
                                          : subjects[index].nameAr,
                                    )));
                          });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  LocaleKeys.new_games.tr(),
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      webgameCard(
                        imagePath: "assets/images/games/Group 624573.png",
                        discussionTitle: LocaleKeys.discussion.tr(),
                        discussion: LocaleKeys.about_discussion.tr(),
                        context: context,
                      ),
                      webgameCard(
                          imagePath: "assets/images/games/Group 20127.png",
                          discussionTitle: LocaleKeys.five_days_chall.tr(),
                          discussion: LocaleKeys.about_5_days_chall.tr(),
                          context: context,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                var height = MediaQuery.of(context).size.height;
                                var width = MediaQuery.of(context).size.width;
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: AlertDialog(
                                    insetPadding: EdgeInsets.symmetric(
                                        horizontal: 200, vertical: 200),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    title: Center(
                                      child: Text('Choose Chapter and lesson'),
                                    ),
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        webDropDown(
                                          // Selecteditems: [
                                          //   'a7a',
                                          //   'sha5ra',
                                          //   'sha5ra b a7a'
                                          // ],
                                          Selecteditems: lessonss
                                              .map(buildMenuitem)
                                              .toList(),
                                          SelectedValue: Selectedvalue2,
                                          onChanged: (valuee) {
                                            setState(() {
                                              Selectedvalue1 = valuee;
                                              value = valuee;

                                              // log(value);
                                              //
                                              // log(chapters[chapters.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == value)].idToEdit);
                                              //
                                              //
                                              // getLessons(chapters[chapters.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == value)].idToEdit);
                                            });
                                          },
                                          context: context,
                                          hint: 'Chapter',
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        webDropDown(
                                          // Selecteditems: [
                                          //   'nfs el a7a',
                                          //   'nfs el sha5ra',
                                          //   'nfs el sha5ra b a7a',
                                          // ],
                                          Selecteditems: lessonss
                                              .map(buildMenuitem)
                                              .toList(),
                                          SelectedValue: Selectedvalue2,
                                          onChanged: (value) {
                                            setState(() {
                                              Selectedvalue2 = value;
                                            });
                                          },
                                          context: context,
                                          hint: 'Lesson',
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          smalldefaultButton(
                                            context: context,
                                            color: Colors.white70,
                                            textColor: Colors.black,
                                            text: LocaleKeys.cancel.tr(),
                                            onpressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                          ),
                                          smalldefaultButton(
                                            color: dodblue,
                                            text: LocaleKeys.submit.tr(),
                                            onpressed: () {},
                                            context: context,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                      webgameCard(
                        imagePath: "assets/images/games/Group 624572.png",
                        discussionTitle: LocaleKeys.challenge.tr(),
                        discussion: LocaleKeys.about_chall.tr(),
                        context: context,
                      ),
                    ],
                  ),
                ),
                webscoreStack(
                  subject: "Subject: $subName",
                  score: LocaleKeys.last_test_score.tr(),
                  context: context,
                  percent: lastTestPercentage.toInt(),
                  foregroundColor: Colors.blue.shade400,
                  direction: Localizations.localeOf(context).toString() == "en"
                      ? Direction.rtl
                      : Direction.ltr,
                  backgroundColor: Colors.blueAccent.shade700,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                webscoreStack(
                  subject: "Subject: Math",
                  score: LocaleKeys.last_game_score.tr(),
                  context: context,
                  percent: 42,
                  foregroundColor: Colors.pink.shade300,
                  direction: Localizations.localeOf(context).toString() == "en"
                      ? Direction.rtl
                      : Direction.ltr,
                  backgroundColor: Colors.pink.shade800,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
