import 'package:cryptokeep/auth/auth.dart';
import 'package:cryptokeep/components/splash_component.dart';
import 'package:cryptokeep/services/user_service.dart';
import 'package:cryptokeep/utils/common.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var enablePasswordAuth = false;
  TextEditingController _controller = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();

    AppAuthentication()
        .initAuth()
        .then((value) => handleBiometricsAuthentication(value));
  }

  void handleBiometricsAuthentication(value) {
    if (value) {
      Future.delayed(Duration(milliseconds: 400), () {
        Navigator.of(context).pushReplacementNamed("/home");
      });
    } else {
      setState(() {
        enablePasswordAuth = true;
      });
    }
  }

  void handleSubmit(BuildContext context, AuthType authType) {
    String password = _controller.value.text;
    if (authType == AuthType.password) handlePasswordAuth(context, password);
  }

  void handlePasswordAuth(BuildContext context, String password) {
    UserRepository.signIn(context, password);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Logo.png",
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 20,
              ),
              getTextBoxOrTitle(
                context,
                enablePasswordAuth,
                _controller,
                handleSubmit,
                handleBiometricsAuthentication,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
