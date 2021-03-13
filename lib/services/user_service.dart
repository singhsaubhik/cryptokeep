import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/models/user_model.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserRepository {
  BuildContext _context;

  UserRepository._privateConstructor(BuildContext context) {
    this._context = context;
  }

  static UserRepository instance(BuildContext context) {
    return UserRepository._privateConstructor(context);
  }

  void saveUser(User user) {
    var box = Hive.box<dynamic>(USER_BOX);
    box.put(IS_USER, user.toMap());
    Navigator.of(_context).pushReplacementNamed("/home");
  }

  static void signIn(BuildContext context, String masterPassword) async {
    final response = Hive.box<dynamic>(USER_BOX).get(IS_USER);
    final isAuth = response["masterPassword"] == masterPassword;

    if (!isAuth) {
      AppSnackBar.show(context, text: "Auth Failed");
    } else
      Navigator.of(context).pushReplacementNamed("/home");
  }
}
