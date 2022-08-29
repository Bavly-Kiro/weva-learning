import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_player/video_player.dart';
import '../../back/checkConnection.dart';
import '../../back/loading.dart';
import '../widgets/default_button.dart';
import '../widgets/default_text_button.dart';
import 'Discussion.dart';
import 'Exam.dart';

// ignore_for_file: prefer_const_constructors
class SelectedLesson extends StatefulWidget {
  SelectedLesson({Key? key, required this.videoID, required this.chaName, required this.lessonName, required this.videoName}) : super(key: key);

  String videoID;
  String chaName;
  String lessonName;
  String videoName;

  @override
  State<SelectedLesson> createState() => _SelectedLessonState();
}

class _SelectedLessonState extends State<SelectedLesson> {
  TextEditingController notesController = TextEditingController();

  String URL = "";
  String imgURL = "";

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
        });

        Navigator.of(context).pop();

       // _controller = VideoPlayerController.network(URL);


        videoPlayerController = VideoPlayerController.network(URL);

        await videoPlayerController.initialize();


        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: true,
        );

       // _controller.initialize();
      }).onError((error, stackTrace) {
        log(error.toString());
        showToast("Error: $error");
      });
    } else {
      showToast("Check Internet Connection !");
    }
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  //late VideoPlayerController _controller;

  void startVideo() {
    setState(() {
      play = false;

      chewieController.play();
    });
  }

  void stopVideo() {
    setState(() {
      play = true;

      chewieController.pause();
    });
  }

  bool play = true;


  late final videoPlayerController;


  late final chewieController;


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
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      play
                          ? Image.network(
                              imgURL,
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.25,
                            )
                          : Container(),
                      play
                          ? IconButton(
                              onPressed: () {
                                startVideo();
                              },
                              icon: Icon(
                                Icons.play_circle,
                                color: Colors.white70,
                                size: 70,
                              ),
                            )
                          : Container(),
                      play == false
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.90,
                              child: InkWell(
                                  onTap: () async {
                                    stopVideo();
                                  },
                                  child: Chewie(
                                    controller: chewieController,
                                  )))
                          : Container(),
                    ],
                  ),
                ),
                Row(
                  children: [
                    defaultTextButton(
                      text: 'Download PDF',
                      onpressed: () {},
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
                      'Notes',
                      style: GoogleFonts.rubik(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    defaultTextButton(
                      text: 'Save Notes',
                      onpressed: () {},
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
                      hintText: 'Write Notes Here',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                Text(
                  'Exam:',
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
                    defaultButton(
                      context: context,
                      color: Colors.green,
                      text: 'Easy',
                      onpressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Exam()));
                      },
                    ),
                    defaultButton(
                      context: context,
                      color: Colors.yellow.shade800,
                      text: 'Medium',
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Discussion()));
                      },
                    ),
                    defaultButton(
                      context: context,
                      color: Colors.red,
                      text: 'Hard',
                      onpressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
