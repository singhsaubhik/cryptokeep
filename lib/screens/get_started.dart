import 'package:cryptokeep/models/user_model.dart';
import 'package:cryptokeep/repository/user_repository.dart';
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 25),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  "Welcome to CryptoKeep",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  "your own place to securely save all your passwords",
                  style: TextStyle(fontSize: 16, color: Colors.blue.shade200),
                ),
                SizedBox(height: 50),
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
                SizedBox(height: 30),
                MaterialButton(
                  color: Theme.of(context).accentColor,
                  minWidth: double.infinity,
                  onPressed: () => this.onSubmit(context),
                  child: Text("Get Started"),
                ),
                SizedBox(height: 30),
                Text("Note: Your all password will be encrypted saved locally.")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
