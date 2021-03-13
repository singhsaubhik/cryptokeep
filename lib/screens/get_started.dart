import 'package:cryptokeep/models/user_model.dart';
import 'package:cryptokeep/services/user_service.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final masterPassController = TextEditingController();

  InputDecoration getDecoration(BuildContext context, String hintText) {
    return InputDecoration(
      hintText: hintText,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor)),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor)),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor)),
    );
  }

  String getValidator(String value, String formName) {
    return value.isEmpty ? "Please enter $formName" : null;
  }

  onSubmit(context) {
    final state = _key.currentState.validate();
    if (!state) return;

    UserRepository.instance(context).saveUser(User(
      fullName: nameController.text,
      email: emailController.text,
      masterPassword: masterPassController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Get started"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "Welcome to CryptoKeep",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  "your own place to securely save all your passwords",
                  style: TextStyle(fontSize: 16, color: Colors.blue.shade200),
                ),
                SizedBox(height: 35),
                TextFormField(
                  controller: nameController,
                  validator: (v) => getValidator(v, "Name"),
                  decoration: getDecoration(context, "Enter Full name"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  validator: (v) => getValidator(v, "Email"),
                  decoration: getDecoration(context, "Enter email"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: masterPassController,
                  validator: (v) => getValidator(v, "Master Password"),
                  decoration: getDecoration(context, "Enter master password"),
                ),
                SizedBox(height: 15),
                MaterialButton(
                  color: Theme.of(context).accentColor,
                  minWidth: double.infinity,
                  onPressed: () => this.onSubmit(context),
                  child: Text("Get Started"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
