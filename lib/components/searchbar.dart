import 'package:cryptokeep/provider/password_provider.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PasswordProvider>(context);

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
              ),
              style: TextStyle(
                color: Colors.white60,
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.search,
                color: primaryTextColor,
              ),
              onPressed: () {
                provider.filter(controller.text);
                FocusScope.of(context).unfocus();
              }),
        ],
      ),
    );
  }
}
