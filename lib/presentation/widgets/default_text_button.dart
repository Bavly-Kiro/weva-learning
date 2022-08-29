import 'package:flutter/material.dart';

Widget defaultTextButton({
  required color,
  required String text,
  required onpressed,
}) =>
    TextButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          color: color,
        ),
      ),
    );
