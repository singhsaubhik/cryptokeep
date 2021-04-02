import 'package:cryptokeep/controller/login_details_controller.dart';
import 'package:cryptokeep/models/login_model.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginDetails extends GetView<LoginDetailsController> {
  final controller = Get.put(LoginDetailsController());

  @override
  Widget build(BuildContext context) {
    // final _login = controller.getLoginById();
    final Login _login = Get.routing.args;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kInactiveCardColour,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/update", arguments: _login);
          },
          child: Icon(
            Icons.edit,
            color: kIconColor,
          ),
        ),
        body: Column(
          children: [
            BuildTopTitle(_login),
            SizedBox(height: 5),
            TopSecondPanel(),
            SizedBox(height: 20),
            _LoginDetailsPanel(_login)
          ],
        ),
      ),
    );
  }
}

class _LoginDetailsPanel extends GetView<LoginDetailsController> {
  final Login _login;

  const _LoginDetailsPanel(this._login);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextFormField(
            readOnly: true,
            controller: TextEditingController(text: _login.username),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.verified_user,
              ),
              suffix: GestureDetector(
                onTap: () => controller.onCopyClick(_login.username, 0),
                child: Icon(
                  Icons.copy,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(.7),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Obx(() {
            return TextFormField(
              obscureText: !controller.showPassword.value,
              readOnly: true,
              controller: TextEditingController(text: _login.password),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                ),
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => controller.toggleShowPassword(),
                      child: Icon(
                        controller.showPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => controller.onCopyClick(_login.password, 1),
                      child: Icon(
                        Icons.copy,
                      ),
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class BuildTopTitle extends StatelessWidget {
  final Login _login;

  BuildTopTitle(this._login);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: kInactiveCardColour,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Text(
            _login.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

class TopSecondPanel extends StatelessWidget {
  const TopSecondPanel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Color(0xFF797979).withOpacity(.2),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildIconWithText(
            "Category",
            Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          BuildIconWithText(
            "Password Score",
            Text(
              "10 / 10",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          BuildIconWithText(
            "Favorite",
            Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildIconWithText extends StatelessWidget {
  final String title;
  final Widget child;

  const BuildIconWithText(this.title, this.child);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
        ),
        SizedBox(
          height: 5,
        ),
        child
      ],
    );
  }
}
