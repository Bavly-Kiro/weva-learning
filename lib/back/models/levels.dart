import 'package:flutter/material.dart';

class level {

  final String idToEdit;
  final String nameAr;
  final String nameEN;
  bool checkBoxValue;
  Checkbox checkBox;
  final String text;
  final String price;
  bool isExpanded;
  final String status;



  level({required this.idToEdit, required this.nameAr, required this.nameEN
    , required this.price, required this.checkBox, required this.checkBoxValue
    , required this.text, required this.isExpanded, required this.status});
}


class friend {

  final String idToEdit;
  final String name;
  final String number;
  final String imageURL;
  final String userID;
  final String friendID;




  friend({required this.idToEdit, required this.name, required this.number
    , required this.imageURL, required this.userID, required this.friendID});
}