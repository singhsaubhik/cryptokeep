import 'package:cryptokeep/dao/dao.dart';
import 'package:cryptokeep/exceptions/validation_exceptions.dart';
import 'package:cryptokeep/models/login_model.dart';
import 'package:cryptokeep/provider/login_provider.dart';
import 'package:cryptokeep/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginService {
  PasswordProvider _provider;

  LoginService._privateConstructor(BuildContext context) {
    this._provider = Provider.of<PasswordProvider>(context, listen: false);
  }

  static LoginService instance(BuildContext context) =>
      LoginService._privateConstructor(context);

  void filter(String searchText) async {
    _provider.filter(searchText);
  }

  void handleDeleteCard(Login object) async {
    this._provider.setIsLoading(true);
    var response = await DBHelper.instance.deleteByID(object.id);
    print(response);
    await Future.delayed(Duration(milliseconds: 350));
    this._provider.removeItem(object, isLoading: false);
  }

  /// Operations on Logins

  void createLogin(Login object) async {
    try {
      validateLogin(object);
    } on ValidationError catch (e) {
      print(e.cause);
      return;
    }

    this._provider.setIsLoading(true);
    var response = await DBHelper.instance.insertOne(object.toMap());
    if (response <= -1) {
      /// TODO: Handle it better
      throw Exception("Could not save");
    }
    this._provider.add(object, isLoading: false);
  }

  void updateLogin(String id, Login login) async {
    this._provider.setIsLoading(true);
    var response = await DBHelper.instance.updateOne(id, login.toMap());
    print(response);
    await Future.delayed(Duration(milliseconds: 350));
    this._provider.updateItem(id, login, isLoading: false);
  }
}
