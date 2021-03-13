import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/models/user_model.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:cryptokeep/utils/encryption.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserRepository {
  BuildContext _context;
  EncryptionService _service;

  UserRepository._privateConstructor(BuildContext context) {
    this._context = context;
    this._service = EncryptionService();
  }

  static UserRepository instance(BuildContext context) {
    return UserRepository._privateConstructor(context);
  }

  void saveUser(User user) {
    var box = Hive.box<dynamic>(USER_BOX);
    user.masterPassword = this._service.encrypt(user.masterPassword);
    box.put(IS_USER, user.toMap());
    Navigator.of(_context).pushReplacementNamed("/home");
  }

  static void signIn(BuildContext context, String masterPassword) async {
    final response = Hive.box<dynamic>(USER_BOX).get(IS_USER);
    String userMasterPassword =
        EncryptionService().decrypt(response["masterPassword"]);

    final isAuth = userMasterPassword == masterPassword;

    if (!isAuth) {
      AppSnackBar.show(context, text: "Auth Failed");
    } else
      Navigator.of(context).pushReplacementNamed("/home");
  }
}
