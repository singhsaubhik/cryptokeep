import 'package:cryptokeep/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _controller = TextEditingController();

class SearchBar extends GetView<HomeController> {
  const SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * .9,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                controller.filter(_controller.text);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Password",
                suffixIcon: IconButton(
                  splashRadius: 1,
                  onPressed: () {
                    controller.filter("");
                    _controller.clear();
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
