import 'package:cryptokeep/controller/password_generator_controller.dart';
import 'package:cryptokeep/services/password_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordGenerator extends GetView<PasswordGeneratorController> {
  final passwordService = PasswordService();
  final controller = Get.put(PasswordGeneratorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.check_circle_outline_rounded),
              onPressed: () {
                Navigator.pop(context, controller.password.value);
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PasswordTextWidget(),
              ActionsContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionsContainer extends GetView<PasswordGeneratorController> {
  const ActionsContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(.5),
      ),
      child: Obx(() {
        return Column(
          children: [
            ActionsWidget(
              title: "Uppercase Letters (A-Z)",
              value: controller.upperCase.value,
              onChange: (v) => controller.setUppercase(v),
            ),
            ActionsWidget(
              title: "Lowercase Letters (a-z)",
              value: controller.lowerCase.value,
              onChange: (v) => controller.setLowercase(v),
            ),
            ActionsWidget(
              title: "Special Letters",
              value: controller.specialLetters.value,
              onChange: (v) => controller.setSpecialLetters(v),
            ),
            ActionsWidget(
              title: "Digits (0-9)",
              value: controller.digits.value,
              onChange: (v) => controller.setDigits(v),
            ),
            Divider(
              color: Colors.blue,
            ),
            Text("Password length"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Slider(
                    value: controller.passwordLength.value,
                    label: controller.passwordLength.value.toString(),
                    onChanged: (v) => controller.setPasswordLength(v),
                    min: 6,
                    max: 32,
                  ),
                  Text(
                    controller.passwordLength.value.floor().toString(),
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}

class ActionsWidget extends StatelessWidget {
  final String title;
  final bool value;
  final Function onChange;

  const ActionsWidget({this.title, this.value, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        Switch(
          value: this.value,
          onChanged: (v) => this.onChange(v),
        ),
      ],
    );
  }
}

class PasswordTextWidget extends GetView<PasswordGeneratorController> {
  const PasswordTextWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return Text(
            controller.password.value,
            style: TextStyle(fontSize: 30,),
            textAlign: TextAlign.center,
          );
        }),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => controller.onCopyClick(),
              icon: Icon(
                Icons.copy,
                color: Colors.blueGrey,
              ),
            ),
            IconButton(
              onPressed: () => controller.generatePassword(),
              icon: Icon(
                Icons.refresh,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
