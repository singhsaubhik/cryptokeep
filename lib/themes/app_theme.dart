import 'package:flutter/material.dart';

class AppTheme {
  static Color bgColor = Color(0xFF2C2D31);
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: bgColor,
    appBarTheme: AppBarTheme(
      color: bgColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white),
        headline1: TextStyle(color: Colors.white)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static AppBar customAppBar = AppBar(
    backgroundColor: bgColor,
    elevation: 0,
  );
}
