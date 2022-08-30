import 'package:flutter/material.dart';

Future<void> loading({required BuildContext? context}) async{
  return await showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (BuildContext context) {
        return Container(child: Center(child: CircularProgressIndicator()));
      });
}
