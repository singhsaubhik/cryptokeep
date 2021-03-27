import 'package:flutter/material.dart';

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
