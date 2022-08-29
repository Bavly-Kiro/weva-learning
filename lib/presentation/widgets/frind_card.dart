import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget friendCard(
    BuildContext context, String name, String imageUrl, String phone) {
  return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            // backgroundColor: Colors.blue,
            radius: MediaQuery.of(context).size.width * 0.09,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  name,
                  style: GoogleFonts.rubik(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  phone,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF616161),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                  color: Color(0X333787ff),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.ac_unit,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'GAME',
                        style: GoogleFonts.rubik(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ));
}
