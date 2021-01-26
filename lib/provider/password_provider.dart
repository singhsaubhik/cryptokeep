import 'dart:collection';

import 'package:cryptokeep/models/password_model.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/foundation.dart';

class PasswordProvider extends ChangeNotifier {
  List<Password> _list = kPasswordData;

  UnmodifiableListView<Password> todoList() {
    return UnmodifiableListView(_list);
  }
}
