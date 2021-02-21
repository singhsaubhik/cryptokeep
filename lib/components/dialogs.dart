import 'package:cryptokeep/models/password_model.dart';
import 'package:flutter/material.dart';

class CreateUpdateDialog extends StatelessWidget {
  final titleController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final Password login;

  CreateUpdateDialog({this.login}) {
    if (this.login != null) {
      titleController.value = titleController.value.copyWith(text: login.title);
      usernameController.value =
          usernameController.value.copyWith(text: login.username);
      passwordController.value =
          passwordController.value.copyWith(text: login.password);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Add New Password",
        style: TextStyle(color: Colors.white60),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                _CreateUpdateDialogInput(
                  titleController,
                  "Enter Title",
                  prefixIcon: Icons.text_fields,
                ),
                SizedBox(
                  height: 10,
                ),
                _CreateUpdateDialogInput(
                  usernameController,
                  "Enter User Name",
                  prefixIcon: Icons.supervised_user_circle_outlined,
                ),
                SizedBox(
                  height: 10,
                ),
                _CreateUpdateDialogInput(
                  passwordController,
                  "Enter Password",
                  obscureText: true,
                  prefixIcon: Icons.lock,
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  var state = _formKey.currentState.validate();
                  if (!state) return;
                  Navigator.of(context).pop({
                    "title": titleController.value.text,
                    "username": usernameController.value.text,
                    "password": passwordController.value.text
                  });
                },
                child: Text("Save"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _CreateUpdateDialogInput extends StatelessWidget {
  const _CreateUpdateDialogInput(this._controller, this.hintText,
      {this.obscureText = false, this.prefixIcon});

  final TextEditingController _controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Theme.of(context).primaryColor,
        disabledColor: Colors.green,
      ),
      child: TextFormField(
        controller: _controller,
        obscureText: this.obscureText,
        validator: (value) {
          /// TODO: Add separate validator for each field
          if (value.isEmpty) {
            return "Please enter value";
          }
          return null;
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: this.hintText,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide:
                BorderSide(color: Colors.white, style: BorderStyle.none),
          ),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white38,
          ),
        ),
      ),
    );
  }
}
