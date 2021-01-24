import 'package:cryptokeep/components/home_component.dart';
import 'package:cryptokeep/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:cryptokeep/utils/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: false,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: Column(
          children: [
            Text(
              "Hi, there",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 40,
              ),
            ),
            PasswordGrid(),
          ],
        ),
      ),
    );
  }
}
