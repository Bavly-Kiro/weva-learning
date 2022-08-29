import 'package:flutter/material.dart';

Widget registrationButton({
  required String text,
  required GestureTapCallback? onTap,
  required BuildContext context,
  Color color = const Color(0XFF3787ff),
  String imagePath = '',
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imagePath.isNotEmpty
              ? Image(
                  image: AssetImage(imagePath),
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                )
              : Container(),
          // SizedBox(width: MediaQuery.of(context).size.width*0.05,),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
