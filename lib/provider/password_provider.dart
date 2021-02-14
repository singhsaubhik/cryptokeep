import 'dart:collection';
import 'package:cryptokeep/dao/dao.dart';
import 'package:cryptokeep/models/password_model.dart';
import 'package:flutter/foundation.dart';

class PasswordProvider extends ChangeNotifier {
  /// Local button state
  ///
  bool _showAddButton = true;

  get showAddButton => _showAddButton;

  void setShowAddButton(bool val) {
    _showAddButton = val;
    notifyListeners();
  }

  ///

  bool _isDBLoaded = false;
  List<Password> _list = [], _initialList = [];
  bool _isLoading = false;

  void _loadFromDB() async {
    _isLoading = true;
    var response = await DBHelper.instance.getAll();

    for (var v in response) {
      _list.add(Password.fromMap(v));
    }
    _initialList = _list.toList();
    _isLoading = false;
    _isDBLoaded = true;
    notifyListeners();
  }

  UnmodifiableListView<Password> passwordList() {
    if (!_isDBLoaded) _loadFromDB();
    return UnmodifiableListView(_list);
  }

  /* Spinner methods */
  get isLoading => _isLoading;

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void add(Password password, {isLoading}) {
    _list.add(password);
    _initialList.add(password);
    if (isLoading != null) _isLoading = isLoading;
    notifyListeners();
  }

  void updateList(List<Password> list, {isLoading}) {
    _list = list;
    if (isLoading != null) _isLoading = isLoading;
    notifyListeners();
  }

  void filter(String text) {
    _list = _initialList
        .where((element) =>
            element.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
