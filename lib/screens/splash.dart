import 'package:cryptokeep/auth/auth.dart';
import 'package:cryptokeep/components/splash_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        enablePasswordAuth = !enablePasswordAuth;
      });
    }
  }

  void handleSubmit() {
    String password = _controller.value.text;
    if (password == "1234") {
      Navigator.of(context).pushReplacementNamed("/home");
    }
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
                height: 120,
                width: 120,
              ),
              SizedBox(
                height: 20,
              ),
              getTextBoxOrTitle(context, _controller, handleSubmit, enablePasswordAuth),
            ],
          ),
        ),
      ),
    );
  }
}
