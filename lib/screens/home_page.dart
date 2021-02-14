import 'package:cryptokeep/components/home_component.dart';
import 'package:cryptokeep/components/searchbar.dart';
import 'package:cryptokeep/models/password_model.dart';
import 'package:cryptokeep/provider/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cryptokeep/repository/respository.dart';

class HomePage extends StatelessWidget {
  void handleAddButton(BuildContext context) async {
    var value = await showDialog(
        context: context,
        builder: (context) {
          return AddPasswordDialog();
        });

    print(value);

    if (value != null) {
      Repository.instance(context).addPassword(
        Password(
          name: value["name"],
          username: value["username"],
          password: value["password"],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PasswordProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: false,
          title: Text("Home"),
          titleSpacing: 24,
          elevation: 0,
        ),
        floatingActionButton: Visibility(
          visible: provider.showAddButton,
          child: FloatingActionButton(
            onPressed: () => handleAddButton(context),
            child: Icon(Icons.add),
          ),
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

class AddPasswordDialog extends StatelessWidget {
  final nameC = TextEditingController();
  final userNameC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Add New Password",
        style: TextStyle(color: Colors.white60),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameC,
            decoration: InputDecoration(
              hintText: "Enter Name",
            ),
          ),
          TextField(
            controller: userNameC,
            decoration: InputDecoration(
              hintText: "Enter user name",
            ),
          ),
          TextField(
            controller: passwordC,
            decoration: InputDecoration(
              hintText: "Enter Password",
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop({
                  "name": nameC.value.text,
                  "username": userNameC.value.text,
                  "password": passwordC.value.text
                }),
                child: Text("Save"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
