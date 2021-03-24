import 'package:cryptokeep/auth/auth.dart';
import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:cryptokeep/utils/encryption.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SplashController extends GetxController {
  var configs;

  @override
  void onInit() {
    super.onInit();
    final box = Hive.box<dynamic>(SETTINGS_CONFIG_BOX);
    configs = box.get(CONFIGS, defaultValue: DEFAULT_CONFIGS);
    loginWithFP(isAppStart: true);
  }

  @override
  void onClose() {
    print("OnClose called");
    super.onClose();
  }

  void loginWithPassword(BuildContext context, String password) {
    final user = Hive.box<dynamic>(USER_BOX).get(IS_USER);
    final userPassword = EncryptionService().decrypt(user[MASTER_PASSWORD]);
    if (password == userPassword) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  void loginWithFP({isAppStart = false}) async {
    final context = Get.context;
    if (configs[LOGIN_WITH_FP]) {
      final isAuthenticated = await AppAuthentication().initAuth();

      if (isAuthenticated) {
        Navigator.pushNamed(context, "/home");
      }
    } else if (!isAppStart) {
      AppSnackBar.show(context, text: "Login with FingerPrint is disabled");
    }
  }
}
