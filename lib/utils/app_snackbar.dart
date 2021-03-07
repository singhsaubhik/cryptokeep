import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(
    BuildContext context, {
    String text,
    Widget child,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: text.isNotEmpty ? Text(text) : child,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
