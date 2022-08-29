import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget drawerRow({
  required BuildContext context,
  required IconData icon,
  required String title,
  required GestureTapCallback? onTap,
}) {
  return GestureDetector(
    child: Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          bottom: MediaQuery.of(context).size.height * 0.02),
      child: Row(
        children: [
          Icon(icon,
              size: MediaQuery.of(context).size.width * 0.08,
              color: Colors.black),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Text(title,
              style: GoogleFonts.rubik(
                color: const Color(0XFF3f3f3f),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              )),
        ],
      ),
    ),
    onTap: onTap,
  );
}
