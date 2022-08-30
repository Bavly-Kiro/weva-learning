import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../translations/locale_keys.g.dart';
import '../widgets/LTile.dart';
import '../widgets/aTXTFld.dart';
import '../widgets/cerved_container.dart';
import '../widgets/registration_button.dart';

class FriendProfile extends StatefulWidget {
  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

enum Menu {
  itemOne,
  itemTwo,
  itemThree,
  itemFour,
}

class _FriendProfileState extends State<FriendProfile> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Color(0XFFe4f1f8),
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
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                )),
            PopupMenuButton<Menu>(
                color: Colors.white,
                // onSelected: (Menu item) {
                //   setState(() {
                //     _selectedMenu = item.name;
                //   });
                // },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                      PopupMenuItem<Menu>(
                        value: Menu.itemOne,
                        onTap: () {
                          print('Report');
                        },
                        child: Text('Report'),
                      ),
                      PopupMenuItem<Menu>(
                        value: Menu.itemTwo,
                        onTap: () {
                          print('Share Contact');
                        },
                        child: Text('Share Contact'),
                      ),
                    ]),
          ],
        ),
        backgroundColor: const Color(0XFFe4f1f8),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                friendprofilecervedContainer(context: context),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.25,
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
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            ListTile(
                              leading: Icon(Icons.gradient),
                              title: Text(
                                'Grade',
                                style: GoogleFonts.rubik(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                'Grade 12',
                                style: GoogleFonts.rubik(
                                  fontSize: 14,
                                  color: Color(0XFF868686),
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(Icons.call),
                              title: Text(
                                'Email',
                                style: GoogleFonts.rubik(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                'Daliasam@gmail.com',
                                style: GoogleFonts.rubik(
                                  fontSize: 14,
                                  color: Color(0XFF868686),
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text(
                                'Mobile Number',
                                style: GoogleFonts.rubik(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                '+201035417234',
                                style: GoogleFonts.rubik(
                                  fontSize: 14,
                                  color: Color(0XFF868686),
                                ),
                              ),
                              onTap: () {},
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
