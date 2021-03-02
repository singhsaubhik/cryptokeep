import 'package:cryptokeep/auth/auth.dart';
import 'package:cryptokeep/utils/common.dart';
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
      ? PasswordInput(controller, onSubmit, onFingerPrint)
      : Text(
          "CryptoKeep",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 40,
          ),
        ));
}

/// TODO: Make this is as a independant component
class PasswordInput extends StatelessWidget {
  final TextEditingController _controller;
  final Function _onSubmit, _onFingerPrint;

  final _key = GlobalKey<FormState>();

  PasswordInput(this._controller, this._onSubmit, this._onFingerPrint);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 1.5),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          width: MediaQuery.of(context).size.width * .8,
          child: Form(
            key: _key,
            child: TextFormField(
              controller: _controller,
              autocorrect: false,
              obscureText: true,
              enableSuggestions: false,
              style: TextStyle(color: Colors.white),
              validator: (value) {
                if (value.isEmpty) return "Enter master password";
                return null;
              },
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (_key.currentState.validate())
                      _onSubmit(AuthType.password);
                  },
                  child: Icon(
                    Icons.lock_open_outlined,
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
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => handleFingerPress(_onFingerPrint),
          child: Icon(
            Icons.fingerprint_rounded,
            size: 40,
          ),
        )
      ],
    );
  }
}
