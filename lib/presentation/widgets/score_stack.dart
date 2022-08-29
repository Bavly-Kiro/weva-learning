import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weva/presentation/widgets/progress_card.dart';

enum Direction {
  ltr,
  rtl,
}

Widget scoreStack({
  required String subject,
  required String score,
  required BuildContext context,
  required int percent,
  required Color foregroundColor,
  required Color backgroundColor,
  required Direction direction,
}) {
  return Stack(
    alignment: direction == Direction.rtl
        ? Alignment.centerRight
        : Alignment.centerLeft,
    children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(score,
                    style: GoogleFonts.rubik(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(subject,
                    style: GoogleFonts.rubik(
                      fontSize: 9,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: progressCard(
            percent: percent,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            context: context),
      )
    ],
  );
}
