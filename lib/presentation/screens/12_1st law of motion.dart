import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../../back/models/subject.dart';
import '../../constants.dart';
import '13_selectedLesson.dart';

// ignore_for_file: prefer_const_constructors
class ListofVids extends StatefulWidget {
  ListofVids(
      {Key? key,
      required this.chName,
      required this.lessonID,
      required this.nameAR,
      required this.nameEN,
      required this.lesonNum})
      : super(key: key);

  String chName;
  String lessonID;
  String nameAR;
  String nameEN;
  int lesonNum;

  @override
  State<ListofVids> createState() => _ListofVidsState();
}

class _ListofVidsState extends State<ListofVids> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getVideos();
  }

  List<video> videos = [];

  void getVideos() async {
    videos = [];

    if (await checkConnectionn()) {
      loading(context: context);

      FirebaseFirestore.instance
          .collection('videos')
          .where("lessonID", isEqualTo: widget.lessonID)
          .get(const GetOptions(source: Source.server))
          .then((value) {
        final List<video> loadData = [];

        for (var element in value.docs) {
          //element.data();
          //log(element.data()['nameAr'].toString());

          loadData.add(video(
            idToEdit: element.id,
            nameAr: element.data()['nameAr'] ?? "",
            nameEN: element.data()['nameEN'] ?? "",
            URL: element.data()['URL'] ?? "",
            subjectID: element.data()['subjectID'] ?? "",
            chapterID: element.data()['chapterID'] ?? "",
            lessonID: element.data()['lessonID'] ?? "",
            mrID: element.data()['mrID'] ?? "",
            vidNum: element.data()['vidNum'] ?? "",
            imgURL: element.data()['imgURL'] ?? "",
            documentURL: element.data()['documentURL'] ?? "",
            userDoneAction: element.data()['userDoneAction'] ?? "",
            LastUserDoneAction: element.data()['LastUserDoneAction'] ?? "",
            status: element.data()['status'] ?? "",
          ));
        }

        loadData.sort((a, b) => a.vidNum.compareTo(b.vidNum));

        setState(() {
          videos = loadData;
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
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xffe4f1f8),
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 50.0,
                      left: 25.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text(
                          widget.chName,
                          style: GoogleFonts.rubik(
                            color: dodblue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Text(
                              'Lesson ${widget.lesonNum} |',
                              style: GoogleFonts.rubik(
                                color: dodblue,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              Localizations.localeOf(context).toString() == "en"
                                  ? widget.nameEN
                                  : widget.nameAR,
                              style: GoogleFonts.rubik(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: LinearPercentIndicator(
                                padding: EdgeInsets.all(0.0),
                                width: 200.0,
                                percent: 60 / 100,
                                barRadius: Radius.circular(20),
                                // animation: true,
                                // animationDuration: 1500,
                                progressColor: dodblue,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.play_circle,
                                color: dodblue,
                                size: 32.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemCount: videos.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 20,
                    shadowColor: Colors.black.withOpacity(0.3),
                    child: ListTile(
                      // tileColor: Colors.white.withOpacity(0.1),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      //   // side:  BorderSide(
                      //   //   color: Colors.black,
                      //   // ),
                      // ),
                      isThreeLine: true,
                      dense: false,
                      visualDensity: VisualDensity(vertical: 4), // to compact

                      contentPadding: EdgeInsets.all(10.0),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectedLesson(
                                    videoID: videos[index].idToEdit,
                                    chaName: widget.chName,
                                    lessonName: Localizations.localeOf(context)
                                                .toString() ==
                                            "en"
                                        ? widget.nameEN
                                        : widget.nameAR,
                                    videoName: Localizations.localeOf(context)
                                                .toString() ==
                                            "en"
                                        ? videos[index].nameEN
                                        : videos[index].nameAr)));
                      },
                      title: Text(
                        Localizations.localeOf(context).toString() == "en"
                            ? videos[index].nameEN
                            : videos[index].nameAr,
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.people_outline),
                          Text(
                            ' 1200 students enrolled',
                            style: GoogleFonts.rubik(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              videos[index].imgURL,
                              height: 150.0,
                              width: 100.0,
                              fit: BoxFit.fill,
                            ),
                            Icon(
                              Icons.play_circle,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
