import 'package:flutter/material.dart';
import 'package:mobile/theme/app_color.dart';

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
    scaffoldBackgroundColor: AppColor.bgDarkThemeColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.bgDarkThemeColor,
    ),
  );
}