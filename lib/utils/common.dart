import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

enum AuthType { fingerprint, password }
enum LoginAction { create, update }

void unfocusAndNavigate(BuildContext context, String route,
    {dynamic arguments}) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    currentFocus.focusedChild.unfocus();
  }

  Navigator.of(context).pushNamed(route, arguments: arguments);
}

Future setScreenCapture(bool val) async {
  const MethodChannel _channel = const MethodChannel(CHANNEL);
  if (!Platform.isAndroid) return;

  if (val) {
    return await _channel.invokeMethod("disableScreenCapture");
  }
  return await _channel.invokeMethod("enableScreenCapture");
}
