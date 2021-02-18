import 'package:cryptokeep/components/dialogs.dart';
import 'package:cryptokeep/components/home_component.dart';
import 'package:cryptokeep/components/searchbar.dart';
import 'package:cryptokeep/models/password_model.dart';
import 'package:flutter/material.dart';
import 'package:cryptokeep/repository/repository.dart';

class HomePage extends StatelessWidget {
  void handleAddButton(BuildContext context) async {
    var value = await showDialog(
        context: context,
        builder: (context) {
          return CreateUpdateDialog();
        });
    if (value != null) {
      Repository.instance(context).addPassword(Password.fromMap(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    /// TODO: Remove ADD button from here and give it to PasswordGrid

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: false,
          title: Text("Home"),
          titleSpacing: 24,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => handleAddButton(context),
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            SearchBar(),
            SizedBox(
              height: 15,
            ),
            PasswordGrid(),
          ],
        ),
      ),
    );
  }
}
