import 'package:cryptokeep/components/dialogs.dart';
import 'package:cryptokeep/dao/dao.dart';
import 'package:cryptokeep/models/password_model.dart';
import 'package:cryptokeep/provider/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Repository {
  PasswordProvider _provider;
  BuildContext _context;

  Repository._privateConstructor(BuildContext context) {
    this._context = context;
    this._provider = Provider.of<PasswordProvider>(context, listen: false);
  }

  static Repository instance(BuildContext context) =>
      Repository._privateConstructor(context);

  void addPassword(Password object) async {
    print(object.id);
    this._provider.setIsLoading(true);
    var response = await DBHelper.instance.insertOne(object.toMap());
    if (response <= -1) {
      // TODO: Handle it better
      throw Exception("Could not save");
    }

    this._provider.add(object, isLoading: false);
  }

  void filter(String searchText) async {
    _provider.filter(searchText);
  }

  void handleDeleteCard(Password object) async {
    this._provider.setIsLoading(true);
    var response = await DBHelper.instance.deleteByID(object.id);
    print(response);
    await Future.delayed(Duration(milliseconds: 350));
    this._provider.removeItem(object, isLoading: false);
  }

  /// Operations on Logins

  void _updateLogin(String id, Password login) async {
    this._provider.setIsLoading(true);
    var response = await DBHelper.instance.updateOne(id, login.toMap());
    print(response);
    await Future.delayed(Duration(milliseconds: 350));
    this._provider.updateItem(id, login, isLoading: false);
  }

  void handleCreateUpdate(String type, Password login) async {
    if (type == "update" && login != null) {
      var value = await showDialog(
        context: _context,
        builder: (context) {
          return CreateUpdateDialog(
            login: login,
          );
        },
      );
      _updateLogin(
        login.id,
        Password.fromValue(value),
      );
    } else {
      var value = await showDialog(
        context: _context,
        builder: (context) {
          return CreateUpdateDialog();
        },
      );
      addPassword(
        Password.fromValue(value),
      );
    }
  }
}
