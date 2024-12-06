import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark();
  static final lightTheme = ThemeData.light()
      .copyWith(visualDensity: VisualDensity.adaptivePlatformDensity);
}
