import 'package:cryptokeep/auth/auth.dart';
import 'package:cryptokeep/components/splash_component.dart';
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

  void handleSubmit(AuthType authType) {
    String password = _controller.value.text;
    var isAuthenticated =
        authType == AuthType.password ? handlePasswordAuth(password) : true;

    if (isAuthenticated) Navigator.of(context).pushReplacementNamed("/home");
  }

  bool handlePasswordAuth(String password) {
    return password == "1234";
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
