import 'package:cryptokeep/dao/dao.dart';
import 'package:cryptokeep/exceptions/validation_exceptions.dart';
import 'package:cryptokeep/models/login_model.dart';
import 'package:cryptokeep/provider/login_provider.dart';
import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginService {
  PasswordProvider _provider;
  BuildContext _context;

  LoginService._privateConstructor(BuildContext context) {
    this._context = context;
    this._provider = Provider.of<PasswordProvider>(context, listen: false);
  }

  static LoginService instance(BuildContext context) =>
      LoginService._privateConstructor(context);

  void filter(String searchText) async {
    _provider.filter(searchText);
  }

  void handleDeleteCard(Login object) async {
    this._provider.setIsLoading(true);

    final shouldDelete = await showDialog(
        context: this._context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Login"),
            content: Text(
                "Are you sure ? Login '${object.title}' will be deleted permanently"),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancel"),
              ),
              MaterialButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Delete"),
                color: Colors.redAccent,
              )
            ],
          );
        });

    if (!shouldDelete) return;

    await DBHelper.instance.deleteByID(object.id);
    this._provider.removeItem(object, isLoading: false);

    await Future.delayed(Duration(milliseconds: 350));
    AppSnackBar.show(this._context, text: "Login deleted successfully");
    Navigator.of(this._context).pop();
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
