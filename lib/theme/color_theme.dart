import 'package:flutter/material.dart';

class ColorTheme {
  static final ColorTheme _instance = ColorTheme._internal();

  factory ColorTheme() {
    return _instance;
  }

  ColorTheme._internal();

  // add colors theme
  Color? primaryColor = Colors.blue[900];
}
