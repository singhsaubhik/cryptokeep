import 'package:cryptokeep/components/bottom_sheet.dart';
import 'package:cryptokeep/controller/home_controller.dart';
import 'package:cryptokeep/models/login_model.dart';
import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/clipboard_manager.dart';
import 'package:cryptokeep/utils/common.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordGrid extends GetView<HomeController> {
  final List<Login> passwordList = [];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.isLoading.value
            ? CircularProgressIndicator()
            : Expanded(
                child: GridView.count(
                  controller: controller.scrollController,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    for (var data in controller.loginList)
                      PasswordCard(Key(data.id), data)
                  ],
                ),
              );
      },
    );
  }
}

class PasswordCard extends StatelessWidget {
  PasswordCard(Key key, this._login);

  final Login _login;

  void handleEditClick(BuildContext context) {
    unfocusAndNavigate(context, "/update", arguments: this._login);
  }

  void handleCopyClick(BuildContext context) {
    ClipBoardManager().copyToClipboard(this._login.password);
    AppSnackBar.show(context, text: PASSWORD_COPIED);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unfocusAndNavigate(context, "/login_details", arguments: this._login);
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheetLayout(_login);
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
                border: Border.all(
                  width: 5,
                  style: BorderStyle.solid,
                  color: Color(0xFFD1D1D1),
                ),
              ),
              child: Text(
                _login.title[0].toUpperCase(),
                style: TextStyle(
                  color: Color(0xFFD1D1D1),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              _login.title,
              style: TextStyle(
                  color: Color(0xFFD7D7D7),
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonWidget(
                  "Edit",
                  borderColor: Colors.grey,
                  onClick: () => handleEditClick(context),
                ),
                ButtonWidget(
                  "Copy",
                  borderColor: Colors.blue[200],
                  onClick: () => handleCopyClick(context),
                ),
              ],
            )
          ],
        ),
        color: Theme.of(context).cardColor,
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  ButtonWidget(this.text, {this.onClick, this.borderColor});

  final String text;
  final Function onClick;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        height: 30,
        width: 65,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            width: 1.5,
            style: BorderStyle.solid,
            color: this.borderColor,
          ),
        ),
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
