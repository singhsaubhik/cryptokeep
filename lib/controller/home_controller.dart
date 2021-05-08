import 'package:cryptokeep/dao/dao.dart';
import 'package:cryptokeep/models/login_model.dart';
import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var showAddButton = true.obs;
  var isLoading = false.obs;
  List<Login> _initialList = [];
  RxList<Login> loginList = RxList<Login>();
  final scrollController = ScrollController();
  var showFavorites = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromDB();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        showAddButton.value = false;
      } else {
        showAddButton.value = true;
      }
    });
  }

  @override
  void onClose() {
    scrollController?.dispose();
    super.onClose();
  }

  void _loadFromDB() async {
    isLoading.value = true;
    var response = await DBHelper.instance.getAll();

    for (var v in response) {
      var _login = Login.fromMap(v, decryptPassword: true);
      loginList.add(_login);
      _initialList.add(_login);
    }
    isLoading.value = false;
  }

  void add(Login password) async {
    /// TODO: Add validation here

    var response = await DBHelper.instance.insertOne(password.toMap());
    if (response <= -1) {
      /// TODO: Handle it better
      throw Exception("Could not save");
    }
    loginList.add(password);
    _initialList.add(password);
  }

  void updateItem(String id, Login login) async {
    /// TODO: Add validation
    var response = await DBHelper.instance.updateOne(id, login.toMap());
    print(response);
    await Future.delayed(Duration(milliseconds: 350));

    var existingLogin = loginList.firstWhere((e) => e.id == id);
    existingLogin.update(login.toMap(favoriteAsBool: true));
    loginList.refresh();
  }

  void removeItem(Login object) async {
    isLoading.value = true;
    await DBHelper.instance.deleteByID(object.id);
    loginList.remove(object);
    _initialList.remove(object);
    isLoading.value = false;
  }

  Login getItemById(String id) {
    if (id == null) return null;

    final _login = loginList.singleWhere((element) => element.id == id);
    return _login;
  }

  void filter(String text) {
    final _list = _initialList
        .where((element) =>
            element.title.toLowerCase().contains(text.toLowerCase()))
        .toList();

    loginList.clear();
    loginList.addAll(_list);
  }

  void handleDeleteCard(BuildContext context, Login object) async {
    final shouldDelete = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Login"),
            content: Text(
                "Are you sure ? Login '${object.title}' will be deleted permanently"),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancel"),
              ),
              MaterialButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Delete"),
                color: Colors.redAccent,
              )
            ],
          );
        });

    if (!shouldDelete) return;
    Navigator.of(context).pop();
    isLoading.value = true;
    await DBHelper.instance.deleteByID(object.id);
    loginList.remove(object);
    await Future.delayed(Duration(milliseconds: 150));
    isLoading.value = false;
    AppSnackBar.show(context, text: "Login deleted successfully");
  }

  void deleteAll() async {
    isLoading.value = true;
    await DBHelper.instance.deleteAll();
    loginList.clear();
    _initialList.clear();
    await Future.delayed(Duration(milliseconds: 150));
    isLoading.value = false;
    AppSnackBar.show(Get.context, text: "All logins deleted succesfully");
  }

  void toggleFavoritesShow(bool value) {
    List<Login> items = [];
    if (value) {
      items =
          _initialList.where((element) => element.favorite == value).toList();
    } else {
      items = _initialList.toList();
    }

    loginList.clear();
    loginList.addAll(items);
    showFavorites.toggle();
  }
}
