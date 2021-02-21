import 'package:cryptokeep/components/home_component.dart';
import 'package:cryptokeep/components/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:cryptokeep/repository/repository.dart';

class HomePage extends StatelessWidget {
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
          onPressed: () =>
              Repository.instance(context).handleCreateUpdate("create", null),
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
