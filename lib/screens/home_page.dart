import 'package:cryptokeep/components/home_component.dart';
import 'package:cryptokeep/components/searchbar.dart';
import 'package:cryptokeep/controller/home_controller.dart';
import 'package:cryptokeep/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cryptokeep/utils/constants.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    /// TODO: Remove ADD button from here and give it to PasswordGrid

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: false,
          title: Text("Home"),
          titleSpacing: 24,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: 20),
              icon: Icon(Icons.settings),
              onPressed: () => unfocusAndNavigate(context, "/settings"),
            ),
          ],
        ),
        floatingActionButton: Obx(() {
          return Visibility(
            visible: controller.showAddButton.value,
            child: FloatingActionButton(
              onPressed: () => unfocusAndNavigate(context, "/create"),
              child: Icon(
                Icons.add,
                color: kIconColor,
              ),
            ),
          );
        }),
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
