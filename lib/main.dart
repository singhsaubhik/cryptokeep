import 'dart:io';

import 'package:cryptokeep/provider/login_provider.dart';
import 'package:cryptokeep/routes.dart';
import 'package:cryptokeep/themes/app_theme.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void setSystemSettings() {
  final settings = SystemUiOverlayStyle(
    systemNavigationBarColor: kScaffoldBackgroundColor, // navigation bar color,
    systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icon
  );
  SystemChrome.setSystemUIOverlayStyle(settings);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setSystemSettings();

  Directory _directory = await getApplicationDocumentsDirectory();
  Hive.init(_directory.path);
  final box = await Hive.openBox(USER_BOX);
  final isFirstRun = box.get(IS_USER, defaultValue: null);

  // box.put(IS_FIRST_RUN, true);

  runApp(MyApp(isFirstRun));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final isUser;

  MyApp(this.isUser);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PasswordProvider(),
      child: MaterialApp(
        title: 'CryptoKeep',
        theme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routes: appRoutes,
        initialRoute: isUser == null ? "/get_started" : "/splash",
      ),
    );
  }
}
