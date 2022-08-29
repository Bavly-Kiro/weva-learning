import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../constants.dart';

Widget selectedFormFiled() {
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
    },
  ];
  TextEditingController typeQuestionController = TextEditingController();
  return SelectFormField(
    type: SelectFormFieldType.dropdown, // or can be dialog
    initialValue: 'circle',
    icon: Icon(Icons.format_shapes),
    labelText: 'Shape',
    items: _items,
    onChanged: (val) => print(val),
    onSaved: (val) => print(val),
  );
}
