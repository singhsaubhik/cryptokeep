import 'package:cryptokeep/controller/app_controller.dart';
import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/common.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:cryptokeep/utils/encryption.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingsController extends GetxController {
  var loginWithFingerPrint = false.obs;
  var darkMode = true.obs;
  var blockScreenshot = true.obs;
  var clearClipboard = false.obs;
  var cleanupDelay = 30.obs;
  var autoLock = false.obs;

  var configBox;

  @override
  void onInit() {
    configBox = Hive.box<dynamic>(SETTINGS_CONFIG_BOX);
    final configs = configBox.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);

    loginWithFingerPrint.value = configs[LOGIN_WITH_FP];
    darkMode.value = configs[IS_DARK_THEME];
    blockScreenshot.value = configs[DISABLE_SCREEN_CAPTURE];
    clearClipboard.value = configs[CLEAR_CLIPBOARD];
    cleanupDelay.value = configs[CLEAN_UP_DELAY];
    autoLock.value = configs[AUTO_LOCK];

    super.onInit();
  }

  void setLoginWithFingerprint(bool value) {
    loginWithFingerPrint.value = value;
    final configs = configBox.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    final newConfigs = Map.from(configs);
    newConfigs[LOGIN_WITH_FP] = value;
    configBox.put(CONFIGS, newConfigs);
  }

  void setDarkMode(bool value) {
    darkMode.value = value;
    var appController = Get.find<AppController>();
    appController.setIsDarkTheme(value);
    final configs = configBox.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    final newConfigs = Map.from(configs);
    newConfigs[IS_DARK_THEME] = value;
    configBox.put(CONFIGS, newConfigs);
  }

  void blockScreenShots(bool value) async {
    blockScreenshot.value = value;
    final configs = configBox.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    final newConfigs = Map.from(configs);
    newConfigs[DISABLE_SCREEN_CAPTURE] = value;
    configBox.put(CONFIGS, newConfigs);
    setScreenCapture(value);
  }

  void setClearClipboard(bool val) {
    clearClipboard.value = val;
    final configs = configBox.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    final newConfigs = Map.from(configs);
    newConfigs[CLEAR_CLIPBOARD] = val;
    configBox.put(CONFIGS, newConfigs);
  }

  void setAutoLock(bool val) {
    autoLock.value = val;
    final configs = configBox.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    final newConfigs = Map.from(configs);
    newConfigs[AUTO_LOCK] = val;
    configBox.put(CONFIGS, newConfigs);
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

  void setCleanupDelay(int value) {
    cleanupDelay.value = value;
    final configs = configBox.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    final newConfigs = Map.from(configs);
    newConfigs[CLEAN_UP_DELAY] = value;
    configBox.put(CONFIGS, newConfigs);
  }
}
