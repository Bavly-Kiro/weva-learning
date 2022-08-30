import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../widgets/aTXTFld.dart';

class LiveComments extends StatefulWidget {
  const LiveComments({Key? key}) : super(key: key);

  @override
  State<LiveComments> createState() => _LiveCommentsState();
}

class _LiveCommentsState extends State<LiveComments> {
  TextEditingController commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'Live',
                style: GoogleFonts.rubik(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Image(
                image: AssetImage('assets/images/signin.png'),
                fit: BoxFit.fill,
              ),
              //   Image.network(
              //       'https://img.freepik.com/free-photo/photo-stunned-displeased-man-makes-size-gesture-demonstrates-how-much-attention-help-he-needs-completes-task-models-desktop_273609-23670.jpg?w=740&t=st=1661759672~exp=1661760272~hmac=666c8bea67c8698a55b15635a88bda8a9c09de1757fbf8f3acb4e388a75d5cd9'),
              // ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.separated(
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Name'),
                      subtitle: Text(Comments[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
              TxtFld(
                controller: commentsController,
                label: 'Add your Comments Here',
                sicon: IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Comments.add(commentsController.text);
                    commentsController.clear();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
