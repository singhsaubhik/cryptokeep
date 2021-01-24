import 'package:cryptokeep/auth/auth.dart';
import 'package:cryptokeep/utils/common.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';

void handleFingerPress(Function onFingerPrint) {
  AppAuthentication().initAuth().then((value) => onFingerPrint(value));
}

Widget getTextBoxOrTitle(
  BuildContext context,
  bool isPasswordAuth,
  controller,
  Function onSubmit,
  Function onFingerPrint,
) {
  return (isPasswordAuth
      ? getPasswordInput(context, controller, onSubmit, onFingerPrint)
      : Text(
          "CryptoKeep",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 40,
          ),
        ));
}

Column getPasswordInput(
  BuildContext context,
  controller,
  Function onSubmit,
  Function onFingerPrint,
) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: MediaQuery.of(context).size.width * .8,
        child: TextField(
          controller: controller,
          autocorrect: false,
          obscureText: true,
          enableSuggestions: false,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () => onSubmit(AuthType.password),
              child: Icon(
                Icons.send_rounded,
                color: Colors.white70,
              ),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Enter master password",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      GestureDetector(
        onTap: () => handleFingerPress(onFingerPrint),
        child: Icon(
          Icons.fingerprint_rounded,
          color: primaryColor,
          size: 40,
        ),
      )
    ],
  );
}
