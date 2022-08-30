import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weva/presentation/screens/12_chapter.dart';

String? Selectedvalue1;
String? Selectedvalue2;
String? GenderValue;
String? countryValue;
String? EduValue;
String? gradeValue;

var items = [
  "Food",
  "Transport",
  "Personal",
  "Shopping",
  "Medical",
  "Rent",
  "Movie",
];

var Genders = [
  "Male",
  "Female",
];

var arabicGenders = [
  "ذكر",
  "انثي",
];

//Localizations.localeOf(context).toString() == "en"? "Male" : "ذكر",


List<String> Subjects = [
  "Math",
  "3rbi",
];

var YearOfEdu = [
  "2 e3dady",
  "3 sanawi",
];

Widget DropDown({
  required context,
  required onChanged,
  required hint,
  required SelectedValue,
  required Selecteditems,
}) =>
    SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        height: MediaQuery.of(context).size.height * 0.075,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffbebab3), width: 1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: DropdownButton<String>(
          value: SelectedValue,
          style: GoogleFonts.rubik(
            color: Colors.black,
          ),
          hint: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              hint,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          isExpanded: true,
          iconSize: 32,
          underline: SizedBox(),
          iconDisabledColor: Color(0xffbebab3),
          items: Selecteditems, //?? items.map(buildMenuitem).toList(),
          onChanged: onChanged,
        ),
      ),
    );
Widget webDropDown({
  required context,
  required onChanged,
  required hint,
  required SelectedValue,
  required Selecteditems,
}) =>
    SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        width: MediaQuery.of(context).size.width * 0.4,

        height: MediaQuery.of(context).size.height * 0.075,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffbebab3), width: 1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: DropdownButton<String>(
          value: SelectedValue,
          style: GoogleFonts.rubik(
            color: Colors.black,
          ),
          hint: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              hint,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          isExpanded: true,
          iconSize: 32,
          underline: SizedBox(),
          iconDisabledColor: Color(0xffbebab3),
          items: Selecteditems, //?? items.map(buildMenuitem).toList(),
          onChanged: onChanged,
        ),
      ),
    );

DropdownMenuItem<String> buildMenuitem(String item) => DropdownMenuItem(
  value: item,
  child: Text(
    item,
    maxLines: null,
    style: TextStyle(
      fontSize: 16.0,
    ),
  ),
);