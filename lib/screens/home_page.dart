import 'package:cryptokeep/components/home_component.dart';
import 'package:cryptokeep/components/searchbar.dart';
import 'package:cryptokeep/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// TODO: Remove ADD button from here and give it to PasswordGrid

    final provider = Provider.of<PasswordProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: false,
          title: Text("Home"),
          titleSpacing: 24,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        floatingActionButton: Visibility(
          visible: provider.showAddButton,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/create");
            },
            child: Icon(Icons.add),
          ),
        ),
        body: Column(
          children: [
            const SearchBar(),
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
