import 'package:flutter/material.dart';

class CreateUpdateDialog extends StatelessWidget {
  final nameC = TextEditingController();
  final userNameC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          "Add New Password",
          style: TextStyle(color: Colors.white60),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CreateUpdateDialogInput(
              userNameC,
              "Enter Title",
              prefixIcon: Icons.text_fields,
            ),
            SizedBox(
              height: 10,
            ),
            _CreateUpdateDialogInput(
              userNameC,
              "Enter User Name",
              prefixIcon: Icons.supervised_user_circle_outlined,
            ),
            SizedBox(
              height: 10,
            ),
            _CreateUpdateDialogInput(
              passwordC,
              "Enter Password",
              obscureText: true,
              prefixIcon: Icons.lock,
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel"),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () => Navigator.of(context).pop({
                    "name": nameC.value.text,
                    "username": userNameC.value.text,
                    "password": passwordC.value.text
                  }),
                  child: Text("Save"),
                ),
              ],
            )
          ],
        ));
  }
}

class _CreateUpdateDialogInput extends StatelessWidget {
  const _CreateUpdateDialogInput(this.controller, this.hintText,
      {this.obscureText = false, this.prefixIcon});

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Theme.of(context).primaryColor,
        disabledColor: Colors.green,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: this.obscureText,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter value";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: this.hintText,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide:
                BorderSide(color: Colors.white, style: BorderStyle.none),
          ),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white38,
          ),
        ),
      ),
    );
  }
}
