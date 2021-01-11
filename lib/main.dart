import 'package:cryptokeep/routes.dart';
import 'package:cryptokeep/screens/home_page.dart';
import 'package:cryptokeep/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoKeep',
      theme: AppTheme.darkTheme,
      routes: appRoutes,
    );
  }
}
//
// Future<void> _checkBiometrics() async {
//   final LocalAuthentication _auth = LocalAuthentication();
//   try {
//     var canCheckBiometrics = await _auth.getAvailableBiometrics();
//     print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxx\n");
//     print(canCheckBiometrics);
//
//   } on Exception catch (e) {
//     print(e);
//   }
// }
