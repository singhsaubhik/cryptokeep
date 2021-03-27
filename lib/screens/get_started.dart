import 'package:cryptokeep/models/user_model.dart';
import 'package:cryptokeep/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _PASSWORD_REGEX =
    r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$";

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

  String nameValidator(String v) {
    if (v.isEmpty) return "Enter full name";
    return null;
  }

  String emailValidator(String v) {
    if (v.isEmpty) return "Enter email";
    if (!GetUtils.isEmail(v)) return "Invalid email";
    return null;
  }

  String passwordValidator(String v) {
    if (v.isEmpty) return "Enter password";
    if (!GetUtils.isLengthBetween(v, 8, 128))
      return "Password length should be at least 8 chars";

    if (!GetUtils.hasCapitalletter(v))
      return "Password should have at least one capital letter";

    if (!GetUtils.hasMatch(v, _PASSWORD_REGEX))
      return "Minimum eight, one uppercase "
          "letter, one lowercase letter, one number and one special character";
    return null;
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Welcome to CryptoKeep",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Your own place to securely save all your passwords",
                    style: TextStyle(fontSize: 16, color: Colors.blue.shade200,),
                  ),
                  SizedBox(height: 35),
                  TextFormField(
                    controller: nameController,
                    validator: (v) => nameValidator(v),
                    decoration: getDecoration(context, "Enter Full name"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    validator: (v) => emailValidator(v),
                    decoration: getDecoration(context, "Enter email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: masterPassController,
                    validator: (v) => passwordValidator(v),
                    decoration: getDecoration(context, "Enter master password"),
                    obscureText: true,
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
      ),
    );
  }
}
