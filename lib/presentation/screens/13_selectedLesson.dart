import 'dart:developer';

//import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../../back/pdfViewerScreen.dart';
import '../../translations/locale_keys.g.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/default_button.dart';
import '../widgets/default_text_button.dart';
import 'Discussion.dart';
import 'Exam.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

// ignore_for_file: prefer_const_constructors
class SelectedLesson extends StatefulWidget {
  SelectedLesson(
      {Key? key,
      required this.videoID,
      required this.chaName,
      required this.lessonName,
      required this.subjectName,
      required this.videoName})
      : super(key: key);

  String videoID;
  String chaName;
  String lessonName;
  String subjectName;
  String videoName;

  @override
  State<SelectedLesson> createState() => _SelectedLessonState();
}

class _SelectedLessonState extends State<SelectedLesson> {
  TextEditingController notesController = TextEditingController();

  String URL = "";
  String imgURL = "";
  String PDFURL = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getVideos();
  }

  void getVideos() async {
    if (await checkConnectionn()) {
      loading(context: context);

      FirebaseFirestore.instance
          .collection('videos')
          .doc(widget.videoID)
          .get(const GetOptions(source: Source.server))
          .then((value) async {
        setState(() {
          URL = value.get("URL");
          imgURL = value.get("imgURL");
          PDFURL = value.get("documentURL");

        });

        // _controller = VideoPlayerController.network(URL);

        //videoPlayerController = VideoPlayerController.network(URL);

        //await videoPlayerController.initialize();

        flickManager = FlickManager(
          onVideoEnd: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return rateAlert(context, widget.videoID,
                      FirebaseAuth.instance.currentUser!.uid);
                });
          },
          videoPlayerController: VideoPlayerController.network(URL),
        );

        setState(() {
          loadingg = false;
        });

        getNotes();

        // _controller.initialize();
      }).onError((error, stackTrace) {
        log(error.toString());
        showToast("Error: $error");
      });
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return noInternetAlert(
              context,
            );
          });
    }
  }

  String noteID = "";

  void getNotes() async {
    if (await checkConnectionn()) {
      FirebaseFirestore.instance
          .collection('Notes')
          .where("userID",
              isEqualTo: await FirebaseAuth.instance.currentUser!.uid)
          .where("videoID", isEqualTo: widget.videoID)
          .get(const GetOptions(source: Source.server))
          .then((value) async {
        for (var element in value.docs) {
          setState(() {
            noteID = element.id;
            notesController.text = element.data()["text"];
          });
        }

        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        log(error.toString());
        showToast("Error: $error");
      });
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return noInternetAlert(
              context,
            );
          });
    }
  }

  @override
  void dispose() {
    //videoPlayerController.dispose();
    flickManager.dispose();
    super.dispose();
  }

  late FlickManager flickManager;

  bool loadingg = true;

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.chaName} > ${widget.lessonName}'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    widget.videoName,
                    style: GoogleFonts.rubik(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: loadingg
                                ? Center(child: CircularProgressIndicator())
                                : VisibilityDetector(key: ObjectKey(flickManager),
                                onVisibilityChanged: (visibility){
                                  log("3333333333333aaaaaaaaaaaaaaaaaaaa");
                                  if (visibility.visibleFraction == 0 && this.mounted) {
                                    flickManager.flickControlManager?.pause();//pausing  functionality
                                  }

                                },
                                child: FlickVideoPlayer(flickManager: flickManager))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      defaultTextButton(
                        text: LocaleKeys.download_pdf.tr(),
                        onpressed: () async {
                          if (await checkConnectionn()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => pdfScreen(PDFURL: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',)));
                          } else {
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
                        color: Colors.teal,
                      ),
                      Icon(
                        Icons.menu_book_outlined,
                        color: Colors.teal,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.notes.tr(),
                        style: GoogleFonts.rubik(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      defaultTextButton(
                        text:
                            '${LocaleKeys.save.tr()} ${LocaleKeys.notes.tr()}',
                        onpressed: () async {
                          if (await checkConnectionn()) {
                            loading(context: context);

                            if (noteID == "") {
                              FirebaseFirestore.instance
                                  .collection("Notes")
                                  .add({
                                'userID': await FirebaseAuth
                                    .instance.currentUser!.uid,
                                'videoID': widget.videoID,
                                'text': notesController.text,
                              }).catchError((error) {
                                showToast("Failed to add: $error");
                                print("Failed to add: $error");
                              }).then((value) {
                                Navigator.of(context).pop();
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection("Notes")
                                  .doc(noteID)
                                  .update({
                                'text': notesController.text,
                              }).catchError((error) {
                                showToast("Failed to add: $error");
                                print("Failed to add: $error");
                              }).then((value) {
                                Navigator.of(context).pop();
                              });
                            }
                          } else {
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
                        color: Colors.teal,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: TextField(
                      controller: notesController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: LocaleKeys.write_notes.tr(),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                  Text(
                    LocaleKeys.exams.tr(),
                    style: GoogleFonts.rubik(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      webdefaultButton(
                        context: context,
                        color: Colors.green,
                        text: LocaleKeys.easy.tr(),
                        onpressed: () {

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return openExam(
                                    context,
                                    widget.videoID,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    "Easy",
                                  widget.subjectName
                                );
                              });
                        },
                      ),
                      webdefaultButton(
                        context: context,
                        color: Colors.yellow.shade800,
                        text: LocaleKeys.moderate.tr(),
                        onpressed: () {

                         // Navigator.push(context, MaterialPageRoute(builder: (context) => Discussion()));

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return openExam(
                                    context,
                                    widget.videoID,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    "Average",
                                    widget.subjectName
                                );
                              });

                        },
                      ),
                      webdefaultButton(
                        context: context,
                        color: Colors.red,
                        text: LocaleKeys.hard.tr(),
                        onpressed: () {

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return openExam(
                                    context,
                                    widget.videoID,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    "Hard",
                                    widget.subjectName
                                );
                              });

                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.chaName} > ${widget.lessonName}'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    widget.videoName,
                    style: GoogleFonts.rubik(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: loadingg
                        ? Center(child: CircularProgressIndicator())
                        : VisibilityDetector(key: ObjectKey(flickManager),
                        onVisibilityChanged: (visibility){
                          log("3333333333333aaaaaaaaaaaaaaaaaaaa");
                          if (visibility.visibleFraction == 0 && this.mounted) {
                            flickManager.flickControlManager?.pause();//pausing  functionality
                          }

                        },
                        child: FlickVideoPlayer(flickManager: flickManager)),
                  ),
                  Row(
                    children: [
                      defaultTextButton(
                        text: LocaleKeys.download_pdf.tr(),
                        onpressed: () async {
                          if (await checkConnectionn()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => pdfScreen(PDFURL: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',)));
                          } else {
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
                        color: Colors.teal,
                      ),
                      Icon(
                        Icons.menu_book_outlined,
                        color: Colors.teal,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.notes.tr(),
                        style: GoogleFonts.rubik(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      defaultTextButton(
                        text:
                            '${LocaleKeys.save.tr()} ${LocaleKeys.notes.tr()}',
                        onpressed: () async {
                          if (await checkConnectionn()) {
                            loading(context: context);

                            if (noteID == "") {
                              FirebaseFirestore.instance
                                  .collection("Notes")
                                  .add({
                                'userID': await FirebaseAuth
                                    .instance.currentUser!.uid,
                                'videoID': widget.videoID,
                                'text': notesController.text,
                              }).catchError((error) {
                                showToast("Failed to add: $error");
                                print("Failed to add: $error");
                              }).then((value) {
                                Navigator.of(context).pop();
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection("Notes")
                                  .doc(noteID)
                                  .update({
                                'text': notesController.text,
                              }).catchError((error) {
                                showToast("Failed to add: $error");
                                print("Failed to add: $error");
                              }).then((value) {
                                Navigator.of(context).pop();
                              });
                            }
                          } else {
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
                        color: Colors.teal,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextField(
                    controller: notesController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: LocaleKeys.write_notes.tr(),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Text(
                    LocaleKeys.exams.tr(),
                    style: GoogleFonts.rubik(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      defaultButton(
                        context: context,
                        color: Colors.green,
                        text: LocaleKeys.easy.tr(),
                        onpressed: () {

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return openExam(
                                  context,
                                  widget.videoID,
                                    FirebaseAuth.instance.currentUser!.uid,
                                  "Easy",
                                  widget.subjectName
                                );
                              });

                        },
                      ),
                      defaultButton(
                        context: context,
                        color: Colors.yellow.shade800,
                        text: LocaleKeys.moderate.tr(),
                        onpressed: () {

                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Discussion()));

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return openExam(
                                    context,
                                    widget.videoID,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    "Average",
                                    widget.subjectName
                                );
                              });

                        },
                      ),
                      defaultButton(
                        context: context,
                        color: Colors.red,
                        text: LocaleKeys.hard.tr(),
                        onpressed: () {

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return openExam(
                                    context,
                                    widget.videoID,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    "Hard",
                                    widget.subjectName
                                );
                              });


                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
