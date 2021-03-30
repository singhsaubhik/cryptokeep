import 'package:cryptokeep/utils/common.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppController extends SuperController {
  var configs;

  @override
  void onInit() {
    super.onInit();
    screenCapture();
  }

  void setIsDarkTheme(bool val) {
    Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
  }

  void screenCapture() async {
    final box = Hive.box<dynamic>(SETTINGS_CONFIG_BOX);
    configs = box.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    setScreenCapture(configs[DISABLE_SCREEN_CAPTURE]);
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    String currentRoute = Get.currentRoute;
    final box = Hive.box<dynamic>(SETTINGS_CONFIG_BOX);
    configs = box.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    var autoLock = configs[AUTO_LOCK];
    if (currentRoute != "/splash" && autoLock) {
      Navigator.pushReplacementNamed(
        Get.context,
        "/splash",
        arguments: currentRoute,
      );
    }
  }
}
