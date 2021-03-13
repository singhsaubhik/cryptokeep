import 'package:flutter/services.dart';

class ClipBoardManager {
  /// TODO: Handle time based clear clipboard

  void copyToClipboard(String data) {
    if (data == null || data == "") return;
    Clipboard.setData(ClipboardData(text: data));
  }

  void clearClipboard() {
    Clipboard.setData(ClipboardData(text: ""));
  }
}
