
import 'package:flutter/material.dart';

Widget cervedContainer({
  required BuildContext context,
}){
  return Container(
    height: MediaQuery.of(context).size.height * 0.6,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    ),
  );
}