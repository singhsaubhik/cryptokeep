import 'package:cryptokeep/dao/dao.dart';
import 'package:cryptokeep/models/password_model.dart';
import 'package:cryptokeep/provider/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Repository {
  PasswordProvider _provider;

  Repository._privateConstructor(BuildContext context) {
    this._provider = Provider.of<PasswordProvider>(context, listen: false);
  }

  static Repository instance(BuildContext context) =>
      Repository._privateConstructor(context);

  void addPassword(Password object) async {
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
}
