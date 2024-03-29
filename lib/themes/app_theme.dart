import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static Color bgColor = Color(0xFF2C2D31);
  static final accentColor = Colors.blueAccent;

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    accentColor: accentColor,
    backgroundColor: kInactiveCardColour,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kAccentColor,
    ),
    scaffoldBackgroundColor: kScaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
      color: kInactiveCardColour,
      elevation: 0,
    ),
    cardColor: kInactiveCardColour,
    dialogTheme: DialogTheme(
      backgroundColor: kInactiveCardColour,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    accentColor: Colors.blue,
    scaffoldBackgroundColor: Colors.grey.shade300,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.blue,
    ),
    cardColor: Colors.blue.shade300,
  );

  static InputDecoration textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blueGrey,
      ),
    ),
  );
}
