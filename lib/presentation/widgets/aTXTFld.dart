import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

Widget TxtFld({
  required TextEditingController controller,
  TextInputType? keyType,
  required String label,
  Icon? picon,
  onTap,
  //required onChanged,
  TextStyle? labelStyle,
  validator,
  IconButton? sicon,
  bool isPassword = false,
  bool? readOnly,
  ValueChanged<String>? onSubmit,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyType,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly ?? false,

      //onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        //label: label,
        labelStyle: GoogleFonts.rubik(fontSize: 16.0),
        focusColor: defaultColor,
        hoverColor: defaultColor,
        prefixIcon: picon,
        suffixIcon: sicon != null ? sicon : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: defaultColor,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: defaultColor,
            width: 2.0,
          ),
        ),
      ),
    );
Widget webTxtFld({
  required context,
  required TextEditingController controller,
  TextInputType? keyType,
  required String label,
  Icon? picon,
  onTap,
  //required onChanged,
  TextStyle? labelStyle,
  validator,
  IconButton? sicon,
  bool isPassword = false,
  bool? readOnly,
  ValueChanged<String>? onSubmit,
}) =>
    Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyType,
        validator: validator,
        onTap: onTap,
        readOnly: readOnly ?? false,

        //onChanged: onChanged,
        onFieldSubmitted: onSubmit,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          //label: label,
          labelStyle: GoogleFonts.rubik(fontSize: 16.0),
          focusColor: defaultColor,
          hoverColor: defaultColor,
          prefixIcon: picon,
          suffixIcon: sicon != null ? sicon : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: defaultColor,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: defaultColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
