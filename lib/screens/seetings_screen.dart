import 'package:cryptokeep/controller/settings_controller.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends GetView<SettingsController> {
  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: AppBar(
            elevation: 0,
            title: Text("Settings"),
          ),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () {
              return Column(
                children: [
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return ChangeMasterPassword();
                      },
                    ),
                    child: SettingItem(
                      title: "Change Master Password",
                      icon: Icons.lock,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  SettingItem2(
                    title: "Login with fingerprint",
                    icon: Icons.fingerprint,
                    value: controller.loginWithFingerPrint.value,
                    onChange: (v) => controller.setLoginWithFingerprint(v),
                  ),
                  SettingItem2(
                    title: "Dark Mode",
                    icon: Icons.brightness_2_outlined,
                    value: controller.darkMode.value,
                    onChange: (v) => controller.setDarkMode(v),
                  ),
                  SettingItem2(
                    title: "Block Screenshots",
                    icon: Icons.stop_screen_share_outlined,
                    value: controller.blockScreenshot.value,
                    onChange: (v) => controller.blockScreenShots(v),
                  ),
                  Divider(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  SettingItem2(
                    title: "Clean clipboard",
                    icon: Icons.cleaning_services_rounded,
                    value: controller.clearClipboard.value,
                    onChange: (v) => controller.setClearClipboard(v),
                  ),
                  Visibility(
                    visible: controller.clearClipboard.value,
                    child: GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return ChangeCleanupTime();
                        },
                      ),
                      child: SettingItem(
                        title: "Clipboard cleanup timeout",
                        icon: Icons.timelapse,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const SettingItem({@required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}

class SettingItem2 extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final Function onChange;

  const SettingItem2({
    @required this.title,
    this.icon,
    this.value,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Switch(value: this.value, onChanged: (v) => onChange(v)),
        ],
      ),
    );
  }
}

class ChangeMasterPassword extends GetView<SettingsController> {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final retypeNew = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Change Master Password"),
      content: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: currentPassword,
            ),
            TextFormField(
              obscureText: true,
              controller: newPassword,
            ),
            TextFormField(
              obscureText: true,
              controller: retypeNew,
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          color: Colors.redAccent,
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final value = {
              "currentPassword": currentPassword.text,
              "newPassword": newPassword.text,
              "retypeNewPassword": retypeNew.text,
            };
            controller.changeMasterPassword(context, value);
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}

class ChangeCleanupTime extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose delay"),
      content: Obx(
        () {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: CLEAR_CLIPBOARD_TIMEOUT_OPTIONS.map((e) {
              return RadioListTile(
                title: Text("$e seconds"),
                value: e,
                groupValue: controller.cleanupDelay.value,
                onChanged: (v) => controller.setCleanupDelay(v),
              );
            }).toList(),
          );
        },
      ),
      actions: [
        MaterialButton(
          color: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    );
  }
}
