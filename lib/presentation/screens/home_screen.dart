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
import '../../back/models/subject.dart';
import '../../cubit/home_cubit/home_cubit_bloc.dart';
import '../../cubit/home_cubit/home_cubit_state.dart';
import '../../translations/locale_keys.g.dart';
import '../widgets/aTXTFld.dart';
import '../widgets/catecory_card.dart';
import '../widgets/game_card.dart';
import '12_chapter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserData();
  }

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

        getSubjects();
      }).onError((error, stackTrace) {
        log(error.toString());
        showToast("Error: $error");
      });
    } else {
      showToast("Check Internet Connection !");
    }
  }

  List<subject> subjects = [];

  void getSubjects() async {
    subjects = [];

    if (await checkConnectionn()) {
      FirebaseFirestore.instance
          .collection('subjects')
          .where("gradeID", isEqualTo: gradeID)
          .get(const GetOptions(source: Source.server))
          .then((value) {
        final List<subject> loadData = [];

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

        setState(() {
          subjects = loadData;
        });

        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        log(error.toString());
        showToast("Error: $error");
      });
    } else {
      showToast("Check Internet Connection !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubitBloc(),
        child: BlocConsumer<HomeCubitBloc, HomeCubitState>(
            listener: (context, state) {},
            builder: (context, state) {
              HomeCubitBloc cubit = HomeCubitBloc.get(context);
              if (kIsWeb) {
                return RefreshIndicator(
                  onRefresh: () => getUserData(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TxtFld(
                            onSubmit: (v) {
                              log("dsfsacsdcsadcsadcsdac sad bs web");
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
                                    title: Localizations.localeOf(context)
                                                .toString() ==
                                            "en"
                                        ? subjects[index].nameEN
                                        : subjects[index].nameAr,
                                    context: context,
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Chapter(
                                                    subjectID: subjects[index]
                                                        .idToEdit,
                                                    name: Localizations
                                                                    .localeOf(
                                                                        context)
                                                                .toString() ==
                                                            "en"
                                                        ? subjects[index].nameEN
                                                        : subjects[index]
                                                            .nameAr,
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
                                  imagePath:
                                      "assets/images/games/Group 624573.png",
                                  discussionTitle: LocaleKeys.discussion.tr(),
                                  discussion: LocaleKeys.about_discussion.tr(),
                                  context: context,
                                ),
                                webgameCard(
                                  imagePath:
                                      "assets/images/games/Group 20127.png",
                                  discussionTitle:
                                      LocaleKeys.five_days_chall.tr(),
                                  discussion:
                                      LocaleKeys.about_5_days_chall.tr(),
                                  context: context,
                                ),
                                webgameCard(
                                  imagePath:
                                      "assets/images/games/Group 624572.png",
                                  discussionTitle: LocaleKeys.challenge.tr(),
                                  discussion: LocaleKeys.about_chall.tr(),
                                  context: context,
                                ),
                              ],
                            ),
                          ),
                          webscoreStack(
                            subject: "Subject: science",
                            score: LocaleKeys.last_test_score.tr(),
                            context: context,
                            percent: 62,
                            foregroundColor: Colors.blue.shade400,
                            direction:
                                Localizations.localeOf(context).toString() ==
                                        "en"
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
                            direction:
                                Localizations.localeOf(context).toString() ==
                                        "en"
                                    ? Direction.rtl
                                    : Direction.ltr,
                            backgroundColor: Colors.pink.shade800,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
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
                              onSubmit: (v) {
                                log("dsfsacsdcsadcsadcsdac sad");
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
                                    title: Localizations.localeOf(context)
                                                .toString() ==
                                            "en"
                                        ? subjects[index].nameEN
                                        : subjects[index].nameAr,
                                    context: context,
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Chapter(
                                                    subjectID: subjects[index]
                                                        .idToEdit,
                                                    name: Localizations
                                                                    .localeOf(
                                                                        context)
                                                                .toString() ==
                                                            "en"
                                                        ? subjects[index].nameEN
                                                        : subjects[index]
                                                            .nameAr,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                gameCard(
                                  imagePath:
                                      "assets/images/games/Group 624573.png",
                                  discussionTitle: LocaleKeys.discussion.tr(),
                                  discussion: LocaleKeys.about_discussion.tr(),
                                  context: context,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                gameCard(
                                  imagePath:
                                      "assets/images/games/Group 20127.png",
                                  discussionTitle:
                                      LocaleKeys.five_days_chall.tr(),
                                  discussion:
                                      LocaleKeys.about_5_days_chall.tr(),
                                  context: context,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                gameCard(
                                  imagePath:
                                      "assets/images/games/Group 624572.png",
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
                            subject: "Subject: science",
                            score: LocaleKeys.last_test_score.tr(),
                            context: context,
                            percent: 62,
                            foregroundColor: Colors.blue.shade400,
                            direction:
                                Localizations.localeOf(context).toString() ==
                                        "en"
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
                            direction:
                                Localizations.localeOf(context).toString() ==
                                        "en"
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
            }));
  }
}
