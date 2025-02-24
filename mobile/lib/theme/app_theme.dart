import 'package:flutter/material.dart';

class AppTheme {

  //light theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    )
  );

  // dark theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff1f2630),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff1f2630)
    )
  );
}