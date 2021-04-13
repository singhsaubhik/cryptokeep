import 'package:cryptokeep/auth/auth.dart';
import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:cryptokeep/utils/encryption.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SplashController extends GetxController {
  final masterPasswordController = TextEditingController(text: "");
  final key = GlobalKey<FormState>();
  var configs;

  @override
  void onInit() {
    super.onInit();
    final box = Hive.box<dynamic>(SETTINGS_CONFIG_BOX);
    configs = box.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    loginWithFP(isAppStart: true);
  }

  void loginWithPassword(BuildContext context) {
    if (!key.currentState.validate()) return;
  }

  String passwordValidator(String val) {
    /// TODO: Add more validation
    final user = Hive.box<dynamic>(USER_BOX).get(IS_USER);
    final userPassword = EncryptionService().decrypt(user[MASTER_PASSWORD]);
    final context = Get.context;
    final arguments = Get.arguments ?? {};
    final route = arguments["currentRoute"] ?? "/home";
    final args = arguments["args"];

    if (val.isEmpty) return "Please enter password";

    if (masterPasswordController.text != userPassword) {
      AppSnackBar.show(context, text: "Incorrect password");
      return "Incorrect password";
    }

    masterPasswordController.text = "";
    Navigator.pushReplacementNamed(context, route, arguments: args);
    return null;
  }

  void loginWithFP({isAppStart = false}) async {
    final context = Get.context;
    // final args = Get.arguments;
    final arguments = Get.arguments ?? {};
    final route = arguments["currentRoute"] ?? "/home";
    final args = arguments["args"];

    if (configs[LOGIN_WITH_FP]) {
      final isAuthenticated = await AppAuthentication().initAuth();

      if (isAuthenticated) {
        masterPasswordController.text = "";
        Navigator.pushReplacementNamed(context, route, arguments: args);
      }
    } else if (!isAppStart) {
      AppSnackBar.show(context, text: "Login with FingerPrint is disabled");
    }
  }
}
