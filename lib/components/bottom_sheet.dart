import 'package:cryptokeep/models/password_model.dart';
import 'package:cryptokeep/repository/repository.dart';
import 'package:flutter/material.dart';

class BottomSheetLayout extends StatelessWidget {
  BottomSheetLayout(this._password);

  final Password _password;

  void _handleItemClick(BuildContext context, String type, Password login) {
    switch (type) {
      case "Delete":
        Navigator.of(context).pop();
        Repository.instance(context).handleDeleteCard(login);
        break;

      case "Edit":
        Navigator.of(context).pop();
        Repository
            .instance(context)
            .handleCreateUpdate("update", login);
        break;
      default:
        Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      color: Theme.of(context).scaffoldBackgroundColor,
      height: MediaQuery.of(context).size.height * .15,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildItem(context, Icons.copy, "Copy", _password),
          buildItem(context, Icons.edit, "Edit", _password),
          buildItem(context, Icons.delete_forever, "Delete", _password)
        ],
      ),
    );
  }

  GestureDetector buildItem(
      BuildContext context, IconData icon, String text, Password login) {
    return GestureDetector(
      onTap: () => _handleItemClick(context, text, login),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blueGrey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
