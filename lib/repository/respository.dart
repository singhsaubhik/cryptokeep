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
    List<Password> _list = [];
    this._provider.setIsLoading(true);
    var response = await DBHelper.instance.find(search: searchText);

    response.forEach((element) {
      _list.add(Password.fromMap(element));
    });
    this._provider.updateList(_list, isLoading: false);
  }
}
