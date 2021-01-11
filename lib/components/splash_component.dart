import 'package:flutter/material.dart';

Widget getTextBoxOrTitle(
    BuildContext context, controller, Function onSubmit, bool value) {
  return (value
      ? Container(
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
                onTap: onSubmit,
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
            textAlign: TextAlign.center,
          ),
        )
      : Text(
          "CryptoKeep",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 40,
          ),
        ));
}
