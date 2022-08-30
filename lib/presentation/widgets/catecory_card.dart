import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget categoryCard({
  required String imagePath,
  required String title,
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
          width: MediaQuery.of(context).size.width * 0.3,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(imagePath),
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget webcategoryCard({
  required String imagePath,
  required String title,
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
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.1,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Text(title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.rubik(
                      fontSize: 12,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
