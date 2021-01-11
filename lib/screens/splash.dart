import 'package:cryptokeep/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 3), (){
    //   Navigator.of(context).pushReplacementNamed("/home");
    // });
    AppAuthentication().initAuth().then((value) => {
          if (value)
            {
              Future.delayed(Duration(milliseconds: 400), () {
                Navigator.of(context).pushReplacementNamed("/home");
              })
            }else{

          }
        });
  }

  void handleAuthentication() {
    // setState(() {
    //   isAuthenticated = !isAuthenticated;
    // });
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
              Text(
                "CryptoKeep",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
