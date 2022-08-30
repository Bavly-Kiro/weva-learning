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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * 0.50,
        height: MediaQuery.of(context).size.width * 0.50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(imagePath),
                height: MediaQuery.of(context).size.width * 0.25,
                width: MediaQuery.of(context).size.width * 0.25,
                fit: BoxFit.cover,
              ),
              Text(
                discussionTitle,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                discussion,
                maxLines: 2,
                overflow: TextOverflow.visible,
                style: GoogleFonts.rubik(
                  fontSize: 9,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget webgameCard({
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
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.2,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fill,
                ),
                Column(
                  children: [
                    Text(discussionTitle,
                        style: GoogleFonts.rubik(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(discussion,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.rubik(
                          fontSize: 12,
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
