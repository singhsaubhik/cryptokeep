import 'package:cryptokeep/themes/app_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppTheme.customAppBar,
        body: Center(
          child: Text(
            "Home Page",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
