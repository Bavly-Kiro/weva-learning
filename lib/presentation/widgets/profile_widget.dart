import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget profileWidget({
  required BuildContext context,
  required ImageProvider image,
  required String name,
  required String email,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.08,
          backgroundColor: Colors.blueAccent,
          backgroundImage: image),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.05,
      ),
      Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.rubik(
              color: const Color(0XFF3f3f3f),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(
            email,
            style: GoogleFonts.rubik(
              color: const Color(0XFF9e9bae),
              fontSize: 12,
            ),
          ),
        ],
      )),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.close,
            size: MediaQuery.of(context).size.width * 0.08,
          )),
    ],
  );
}
