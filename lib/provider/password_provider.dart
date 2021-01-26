import 'dart:collection';

import 'package:cryptokeep/models/password_model.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/foundation.dart';

class PasswordProvider extends ChangeNotifier {
  List<Password> _list = kPasswordData;

  UnmodifiableListView<Password> todoList() {
    return UnmodifiableListView(_list);
  }

  void filter(String text) {
    print(text);
    print(_list);
    final list = kPasswordData
        .where((element) =>
            element.name.toLowerCase().contains(text.toLowerCase()))
        .toList();

    _list = list;
    notifyListeners();
  }
}
