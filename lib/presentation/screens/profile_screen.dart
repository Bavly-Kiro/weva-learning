import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weva/presentation/widgets/LTile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   elevation: 0.0,
        //   backgroundColor: Colors.white,
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.share,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ],
        //   // leading: IconButton(
        //   //   icon: Icon(
        //   //     Icons.arrow_back_ios,
        //   //     color: Colors.black,
        //   //   ),
        //   //   onPressed: () {
        //   //     Navigator.pop(context);
        //   //   },
        //   // ),
        // ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.05,
                  backgroundColor: Colors.blueAccent,
                  backgroundImage: NetworkImage(
                      'https://thumbs.dreamstime.com/b/male-student-portrait-handsome-man-enjoy-study-home-schooling-concept-education-knowledge-work-as-office-assistant-178491145.jpg'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  'Elias Adam',
                  style: GoogleFonts.rubik(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  'email Elias Adam',
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      webLiTile(
                        context: context,
                        icon: Icons.person,
                        title: 'Personal details',
                        onTap: () {},
                      ),
                      webLiTile(
                        context: context,
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: () {},
                      ),
                      webLiTile(
                        context: context,
                        icon: Icons.credit_card,
                        title: 'Payment details',
                        onTap: () {},
                      ),
                      webLiTile(
                        context: context,
                        icon: Icons.speaker_notes,
                        title: 'FAQ',
                        onTap: () {},
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          size: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black,
                        ),
                        title: Text('    Sign out',
                            style: GoogleFonts.rubik(
                              color: const Color(0XFF3f3f3f),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            )),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   elevation: 0.0,
        //   backgroundColor: Colors.white,
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.share,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ],
        //   // leading: IconButton(
        //   //   icon: Icon(
        //   //     Icons.arrow_back_ios,
        //   //     color: Colors.black,
        //   //   ),
        //   //   onPressed: () {
        //   //     Navigator.pop(context);
        //   //   },
        //   // ),
        // ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.15,
                  backgroundColor: Colors.blueAccent,
                  backgroundImage: NetworkImage(
                      'https://thumbs.dreamstime.com/b/male-student-portrait-handsome-man-enjoy-study-home-schooling-concept-education-knowledge-work-as-office-assistant-178491145.jpg'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  'Elias Adam',
                  style: GoogleFonts.rubik(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  'email Elias Adam',
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    LiTile(
                      context: context,
                      icon: Icons.person,
                      title: 'Personal details',
                      onTap: () {},
                    ),
                    LiTile(
                      context: context,
                      icon: Icons.settings,
                      title: 'Settings',
                      onTap: () {},
                    ),
                    LiTile(
                      context: context,
                      icon: Icons.credit_card,
                      title: 'Payment details',
                      onTap: () {},
                    ),
                    LiTile(
                      context: context,
                      icon: Icons.speaker_notes,
                      title: 'FAQ',
                      onTap: () {},
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: MediaQuery.of(context).size.width * 0.08,
                        color: Colors.black,
                      ),
                      title: Text('Sign out',
                          style: GoogleFonts.rubik(
                            color: const Color(0XFF3f3f3f),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
