import 'package:cryptokeep/repository/repository.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * .9,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: kInactiveCardColour,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) => Repository.instance(context).filter(value),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Password",
                suffixIcon: IconButton(
                  splashRadius: 1,
                  onPressed: () {
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
        ],
      ),
    );
  }
}
