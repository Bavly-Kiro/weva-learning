import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget basicTextFormFiled({
  required TextEditingController control,
  required TextInputType type,
  bool obscure = false,
  ValueChanged? onSubmit,
  ValueChanged? onchange,
  GestureTapCallback? onTape,
  FormFieldValidator? validate,
  Color iconColor = Colors.black,
  required String hintText,
}) {
  return TextFormField(
    controller: control,
    keyboardType: type,
    obscureText: obscure,
    onChanged: onchange,
    onTap: onTape,
    validator: validate,
    onFieldSubmitted: onSubmit,
    cursorColor: Colors.black,

    style: GoogleFonts.rubik(fontSize: 18, color: const Color(0XFF868686)),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.rubik(fontSize: 18, color: const Color(0XFF868686)
      ),),
  );
}