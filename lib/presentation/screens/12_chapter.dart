import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';

import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../../back/models/subject.dart';
import '../widgets/dropdown_textField.dart';
import '../widgets/registration_button.dart';
import 'ListofVideos.dart';
import '13_selectedLesson.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// ignore_for_file: prefer_const_constructors

class Chapter extends StatefulWidget {
  Chapter({Key? key, required this.subjectID, required this.name}) : super(key: key);

  String subjectID;
  String name;

  @override
  State<Chapter> createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  var formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();

    getChapters();

  }

  List<chapter> chapters = [];
  List<String> chapterss = [];

  void getChapters() async{

    chapters = [];
    chapterss = [];

    if(await checkConnectionn()){

      loading(context: context);

      FirebaseFirestore.instance.collection('chapters').where("subjectID", isEqualTo: widget.subjectID).get(const GetOptions(source: Source.server))
          .then((value) {


        final List<chapter> loadData = [];

        for (var element in value.docs) {
          //element.data();
          //log(element.data()['nameAr'].toString());

          loadData.add(chapter(
            idToEdit: element.id,
            nameAr: element.data()['nameAr'] ?? "",
            nameEN: element.data()['nameEN'] ?? "",
            subjectID: element.data()['subjectID'] ?? "",
            mrID: element.data()['mrID'] ?? "",
            chNum: element.data()['chNum'] ?? "",

            userDoneAction: element.data()['userDoneAction'] ?? "",
            LastUserDoneAction: element.data()['LastUserDoneAction'] ?? "",
            status: element.data()['status'] ?? "",

          ));

          chapterss.add(Localizations.localeOf(context).toString() == "en" ? element.data()['nameEN'] : element.data()['nameAr']);

        }

        loadData.sort((a, b) => a.chNum.compareTo(b.chNum));

        setState(() {
          chapters = loadData;
        });

        Navigator.of(context).pop();

        //getLessons();

      }).onError((error, stackTrace) {

        log(error.toString());
        showToast("Error: $error");

      });

    }else{

      showToast("Check Internet Connection !");

    }

  }


  List<lesson> lessons = [];
  List<String> lessonss = [];

  void getLessons(chapterID) async{

    lessons = [];
    lessonss = [];

    if(await checkConnectionn()){

      loading(context: context);

      FirebaseFirestore.instance.collection('lessons').where("chapterID", isEqualTo: chapterID).get(const GetOptions(source: Source.server))
          .then((value) {


        final List<lesson> loadData = [];

        for (var element in value.docs) {
          //element.data();
          //log(element.data()['nameAr'].toString());

          loadData.add(lesson(
            idToEdit: element.id,
            nameAr: element.data()['nameAr'] ?? "",
            nameEN: element.data()['nameEN'] ?? "",
            subjectID: element.data()['subjectID'] ?? "",
            chapterID: element.data()['chapterID'] ?? "",
            mrID: element.data()['mrID'] ?? "",
            lessNum: element.data()['lessNum'] ?? "",

            userDoneAction: element.data()['userDoneAction'] ?? "",
            LastUserDoneAction: element.data()['LastUserDoneAction'] ?? "",
            status: element.data()['status'] ?? "",

          ));

          lessonss.add(Localizations.localeOf(context).toString() == "en" ? element.data()['nameEN'] : element.data()['nameAr']);

        }

        loadData.sort((a, b) => a.lessNum.compareTo(b.lessNum));

        setState(() {
          lessons = loadData;
        });

        Navigator.of(context).pop();

      }).onError((error, stackTrace) {

        log(error.toString());
        showToast("Error: $error");

      });

    }else{

      showToast("Check Internet Connection !");

    }

  }


  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 50,
              right: 20,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Stack(
                        children: [
                          Image(
                            image: AssetImage("assets/images/science.png"),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.name,
                          style: GoogleFonts.rubik(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    webDropDown(
                      Selecteditems: chapterss.map(buildMenuitem).toList(),
                      SelectedValue: Selectedvalue1,
                      onChanged: (value) {
                        setState(() {
                          Selectedvalue1 = value;

                          log(value);

                          log(chapters[chapters.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == value)].idToEdit);


                          getLessons(chapters[chapters.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == value)].idToEdit);

                        });
                      },
                      context: context,
                      hint: 'Chapter',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    webDropDown(
                      Selecteditems: lessonss.map(buildMenuitem).toList(),
                      SelectedValue: Selectedvalue2,
                      onChanged: (value) {
                        setState(() {
                          Selectedvalue2 = value;
                        });
                      },
                      context: context,
                      hint: 'Lesson',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    webregistrationButton(
                      text: "Next",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          //Navigate to b2a hna


                          if(Selectedvalue1 != null && Selectedvalue2 != null){

                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ListofVids(chName: Selectedvalue1!, lessonID: lessons[lessons.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == Selectedvalue2)].idToEdit, nameAR: lessons[lessons.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == Selectedvalue2)].nameAr, nameEN: lessons[lessons.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == Selectedvalue2)].nameEN, lesonNum: lessons[lessons.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == Selectedvalue2)].lessNum)));

                          }


                        }
                      },
                      context: context,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 10,
              right: 20,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: Stack(
                        children: [
                          Image(
                            image: AssetImage("assets/images/science.png"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      widget.name,
                      style: GoogleFonts.rubik(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    DropDown(
                      Selecteditems: chapterss.map(buildMenuitem).toList(),
                      SelectedValue: Selectedvalue1,
                      onChanged: (value) {
                        setState(() {
                          Selectedvalue1 = value;

                          log(value);

                          log(chapters[chapters.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == value)].idToEdit);


                          getLessons(chapters[chapters.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == value)].idToEdit);

                        });
                      },
                      context: context,
                      hint: 'Chapter',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    DropDown(
                      Selecteditems: lessonss.map(buildMenuitem).toList(),
                      SelectedValue: Selectedvalue2,
                      onChanged: (value) {
                        setState(() {
                          Selectedvalue2 = value;
                        });
                      },
                      context: context,
                      hint: 'Lesson',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    registrationButton(
                      text: "Next",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          //Navigate to b2a hna


                          if(Selectedvalue1 != null && Selectedvalue2 != null){

                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ListofVids(chName: Selectedvalue1!, lessonID: lessons[lessons.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == Selectedvalue2)].idToEdit, nameAR: lessons[lessons.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == Selectedvalue2)].nameAr, nameEN: lessons[lessons.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == Selectedvalue2)].nameEN, lesonNum: lessons[lessons.indexWhere((f) => (Localizations.localeOf(context).toString() == "en"? f.nameEN : f.nameAr) == Selectedvalue2)].lessNum)));

                          }


                        }
                      },
                      context: context,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );    }

  }
}
