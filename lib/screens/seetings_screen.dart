import 'package:cryptokeep/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text("Settings"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return ChangeMasterPassword();
                      }),
                  child: SettingItem(
                    title: "Change Master Password",
                    icon: Icons.lock,
                  ),
                ),
                GetBuilder<SettingsController>(
                  id: LOGIN_W_FP,
                  init: SettingsController(),
                  builder: (_) {
                    return SettingItem2(
                      title: "Login with fingerprint",
                      icon: Icons.fingerprint,
                      value: _.loginWithFingerPrint,
                      onChange: (v) => _.setLoginWithFingerprint(v),
                    );
                  },
                ),
                GetBuilder<SettingsController>(
                  id: DARK_MODE,
                  builder: (_) {
                    return SettingItem2(
                      title: "Dark Mode",
                      icon: Icons.brightness_2_outlined,
                      value: _.darkMode,
                      onChange: (v) => _.setDarkMode(v),
                    );
                  },
                ),
                GetBuilder<SettingsController>(
                  id: BLOCK_SCREEN_SHOTS,
                  builder: (_) {
                    return SettingItem2(
                      title: "Block Screenshots",
                      icon: Icons.stop_screen_share_outlined,
                      value: _.blockScreenshot,
                      onChange: (v) => _.blockScreenShots(v),
                    );
                  },
                ),
              ],
            ),
          )),
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

class CleanClipboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
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
