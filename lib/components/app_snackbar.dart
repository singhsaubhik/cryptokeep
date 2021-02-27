import 'package:flutter/material.dart';

class AppSnackBar {
  BuildContext _context;
  static AppSnackBar _instance;

  AppSnackBar._privateConstructor(BuildContext context) {
    this._context = context;
  }

  static void init(BuildContext context) {
    _instance = AppSnackBar._privateConstructor(context);
  }

  static AppSnackBar get getInstance => _instance;

  void showAppSnackBar(String text) {
    Scaffold.of(_context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
