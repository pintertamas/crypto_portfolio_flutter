import 'package:flutter/material.dart';

final theme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xff14213D),
  secondaryHeaderColor: Color(0xffE5E5E5),
  accentColor: Color(0xffFCA311),
);

TextStyle detailsTextStyle(int size) {
  return TextStyle(
    color: theme.secondaryHeaderColor,
    fontWeight: FontWeight.bold,
    fontSize: double.parse(size.toString()),
  );
}