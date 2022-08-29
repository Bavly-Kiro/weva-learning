import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget gameCard({
  required String imagePath,
  required String discussion,
  required String discussionTitle,
  required BuildContext context,
  GestureTapCallback? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 5.0),
    child: GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.width * 0.65,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(
                  image: AssetImage(imagePath),
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    Text(discussionTitle,
                        style: GoogleFonts.rubik(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(discussion,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.rubik(
                          fontSize: 10,
                          color: Colors.black,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
