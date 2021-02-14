import 'dart:collection';
import 'package:cryptokeep/dao/dao.dart';
import 'package:cryptokeep/models/password_model.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/foundation.dart';

class PasswordProvider extends ChangeNotifier {
  bool _isDBLoaded = false;
  List<Password> _list = [];
  bool _isLoading = false;

  bool shouldLoadFromDB() => _list.isEmpty && _isDBLoaded;

  void _loadFromDB() async {
    _isLoading = true;
    var response = await DBHelper.instance.getAll();

    for (var v in response) {
      _list.add(Password.fromMap(v));
    }
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

  get isDBLoaded => _isDBLoaded;

  set setIsDBLoaded(value) => _isDBLoaded = value;

  void add(Password password, {isLoading}) {
    _list.add(password);
    if (isLoading != null) _isLoading = isLoading;
    notifyListeners();
  }

  void updateList(List<Password> list, {isLoading}) {
    _list = list;
    if (isLoading != null) _isLoading = isLoading;
    notifyListeners();
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
