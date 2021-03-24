import 'dart:io';

import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

const MethodChannel _channel = const MethodChannel(CHANNEL);

class AppController extends GetxController {
  var isDarkTheme = true.obs;
  var configs;

  @override
  void onInit() {
    super.onInit();
    final box = Hive.box<dynamic>(SETTINGS_CONFIG_BOX);
    configs = box.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    isDarkTheme.value = configs[IS_DARK_THEME];
  }

  void changeTheme() {
    Get.changeThemeMode(ThemeMode.dark);
  }

  void screenCapture() async {
    if (Platform.isAndroid && configs[DISABLE_SCREEN_CAPTURE]) {
      return await _channel.invokeMethod("disableScreenCapture");
    }
  }
}
