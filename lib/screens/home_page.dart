import 'package:cryptokeep/components/home_component.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: false,
          title: Text("Home"),
          titleSpacing: 20,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(Icons.search),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            PasswordGrid(),
          ],
        ),
      ),
    );
  }
}
