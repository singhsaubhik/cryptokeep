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

const kChannel = "com.singhsaubhik.cryptokeep/screencatpure";

void setSystemSettings() {
  final settings = SystemUiOverlayStyle(
    systemNavigationBarColor: kScaffoldBackgroundColor, // navigation bar color,
    systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icon
  );
  SystemChrome.setSystemUIOverlayStyle(settings);
}

Future<dynamic> setConfigs() async {
  /// TODO: Apply disableCaptureScreen on the basis of config
  const MethodChannel _channel = const MethodChannel(kChannel);
  return await _channel.invokeMethod("disableScreenCapture");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setSystemSettings();

  Directory _directory = await getApplicationDocumentsDirectory();
  Hive.init(_directory.path);
  final box = await Hive.openBox(USER_BOX);
  final isUser = box.get(IS_USER, defaultValue: null);
  await setConfigs();
  runApp(MyApp(isUser));
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
