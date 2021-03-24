import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:cryptokeep/utils/encryption.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';

const LOGIN_W_FP = "LOGIN_WITH_FINGER_PRINT";
const DARK_MODE = "DARK_MODE";
const BLOCK_SCREEN_SHOTS = "BLOCK_SCREEN_SHOTS";

class SettingsController extends GetxController {
  var loginWithFingerPrint = false;
  var darkMode = true;
  var blockScreenshot = true;
  var configBox;

  @override
  void onInit() {
    configBox = Hive.box<dynamic>(SETTINGS_CONFIG_BOX);
    final configs = configBox.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);

    loginWithFingerPrint = configs[LOGIN_WITH_FP];
    darkMode = configs[IS_DARK_THEME];
    blockScreenshot = configs[DISABLE_SCREEN_CAPTURE];

    super.onInit();
  }

  void setLoginWithFingerprint(bool value) {
    loginWithFingerPrint = value;
    final configs = configBox.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);

    final newConfigs = {
      LOGIN_WITH_FP: value,
      IS_DARK_THEME: configs[IS_DARK_THEME],
      DISABLE_SCREEN_CAPTURE: configs[DISABLE_SCREEN_CAPTURE]
    };

    configBox.put(CONFIGS, newConfigs);
    update([LOGIN_W_FP]);
  }

  void setDarkMode(bool value) {
    darkMode = value;
    update([DARK_MODE]);
  }

  void blockScreenShots(bool value) {
    blockScreenshot = value;
    update([BLOCK_SCREEN_SHOTS]);
  }

  void changeMasterPassword(BuildContext context, value) async {
    // AppSnackBar.show(context, text: "Hi there");
    final currentPassword = value["currentPassword"];
    final newPassword = value["newPassword"];
    final retypeNewPassword = value["retypeNewPassword"];

    if (newPassword != retypeNewPassword) {
      AppSnackBar.show(context, text: "Password did not match");
      return;
    }
    final user = Hive.box<dynamic>(USER_BOX).get(IS_USER);
    final existingPassword =
        EncryptionService().decrypt(user["masterPassword"]);

    if (currentPassword != existingPassword) {
      AppSnackBar.show(context, text: "Current password is incorrect");
      return;
    }

    user["masterPassword"] = EncryptionService().encrypt(newPassword);
    Hive.box<dynamic>(USER_BOX).put(IS_USER, user);

    Navigator.pop(context);
    AppSnackBar.show(context, text: "Successfully updated");
  }
}
