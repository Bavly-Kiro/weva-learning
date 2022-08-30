import 'package:flutter/material.dart';

Widget smalldefaultButton({
  required String text,
  required onpressed,
  required color,
  required context,
  textColor,
}) =>
    Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: MaterialButton(
        child: Text(
          maxLines: 1,
          textAlign: TextAlign.center,
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 14,
          ),
        ),
        onPressed: onpressed,
      ),
    );
Widget defaultButton({
  required String text,
  required onpressed,
  required color,
  required context,
  textColor,
}) =>
    Container(
      width: MediaQuery.of(context).size.width * 0.275,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: MaterialButton(
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
          ),
        ),
        onPressed: onpressed,
      ),
    );

Widget webdefaultButton({
  required String text,
  required onpressed,
  required color,
  required context,
  textColor,
}) =>
    Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: MaterialButton(
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
          ),
        ),
        onPressed: onpressed,
      ),
    );
