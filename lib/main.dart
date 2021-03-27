import 'dart:io';

import 'package:cryptokeep/controller/app_controller.dart';
import 'package:cryptokeep/routes.dart';
import 'package:cryptokeep/themes/app_theme.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory _directory = await getApplicationDocumentsDirectory();
  Hive.init(_directory.path);
  final box = await Hive.openBox(USER_BOX);
  await Hive.openBox(SETTINGS_CONFIG_BOX);
  final isUser = box.get(IS_USER, defaultValue: null);
  runApp(MyApp(isUser));
}

class MyApp extends GetView<AppController> {
  // This widget is the root of your application.
  final isUser;
  final controller = Get.put(AppController());

  MyApp(this.isUser);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CryptoKeep',
      theme: ThemeData.light(),
      darkTheme: AppTheme.darkTheme,
      themeMode:
          controller.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
      routes: appRoutes,
      initialRoute: isUser == null ? "/get_started" : "/splash",
      // initialRoute: "/get_started",
    );
  }
}
