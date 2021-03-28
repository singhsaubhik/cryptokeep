import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

const _DEFAULT_CLEANUP_TIME = 30;

class ClipBoardManager {
  void copyToClipboard(String data) {
    if (data == null || data == "") return;
    Clipboard.setData(ClipboardData(text: data));

    var box = Hive.box<dynamic>(SETTINGS_CONFIG_BOX);
    var configs = box.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    int cleanupDelay = configs[CLEAN_UP_DELAY];
    if (configs[CLEAR_CLIPBOARD] ?? false) {
      clearClipboard(seconds: cleanupDelay);
    }
  }

  void clearClipboard({int seconds = _DEFAULT_CLEANUP_TIME}) async {
    await Future.delayed(Duration(seconds: seconds));
    Clipboard.setData(ClipboardData(text: ""));
  }
}
