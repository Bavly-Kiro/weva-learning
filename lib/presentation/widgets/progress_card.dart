import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget progressCard({
  required int percent,
  required Color foregroundColor,
  required Color backgroundColor,
  required BuildContext context,
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(MediaQuery.of(context).size.width * 0.09),
    ),
    clipBehavior: Clip.antiAlias,
    child: CircularPercentIndicator(
      radius: MediaQuery.of(context).size.width * 0.09,
      // lineWidth: 5.0,
      percent: percent / 100,
      center: Text(
        "$percent %",
        style: GoogleFonts.rubik(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
      progressColor: foregroundColor,
      backgroundColor: backgroundColor,
      fillColor: backgroundColor,
      animation: true,
      animationDuration: 2000,
    ),
  );
}
