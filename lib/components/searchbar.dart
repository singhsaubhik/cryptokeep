import 'package:cryptokeep/provider/password_provider.dart';
import 'package:cryptokeep/repository/respository.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * .9,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Password",
                suffixIcon: IconButton(
                  onPressed: () {
                    if (controller.value.text != "")
                      Repository.instance(context).filter("");

                    controller.clear();
                    FocusScope.of(context).unfocus();
                  },
                  icon: Icon(Icons.clear),
                ),
              ),
              style: TextStyle(
                color: Colors.white60,
              ),
            ),
          ),
          IconButton(
            tooltip: "Search",
            splashRadius: 1,
            icon: Icon(
              Icons.search,
              color: primaryTextColor,
            ),
            onPressed: () =>
                Repository.instance(context).filter(controller.value.text),
          ),
        ],
      ),
    );
  }
}
