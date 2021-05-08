import 'package:cryptokeep/controller/home_controller.dart';
import 'package:cryptokeep/models/login_model.dart';
import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/clipboard_manager.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetLayout extends GetView<HomeController> {
  BottomSheetLayout(this._password);

  final Login _password;

  void _handleItemClick(BuildContext context, String type, Login login) {
    switch (type) {
      case "Delete":
        controller.handleDeleteCard(context, login);
        break;

      case "Edit":
        Navigator.of(context).pop();
        Navigator.pushNamed(context, "/update", arguments: this._password);
        break;

      case "Copy":
        ClipBoardManager().copyToClipboard(login.password);
        AppSnackBar.show(context, text: PASSWORD_COPIED);
        Navigator.of(context).pop();
        break;
      case "Share":
        Navigator.of(context).pop();
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
          buildItem(context, Icons.delete_forever, "Delete", _password),
          buildItem(context, Icons.share, "Delete", _password),
        ],
      ),
    );
  }

  GestureDetector buildItem(
      BuildContext context, IconData icon, String text, Login login) {
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
