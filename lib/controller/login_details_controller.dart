import 'package:cryptokeep/dao/dao.dart';
import 'package:cryptokeep/models/login_model.dart';
import 'package:cryptokeep/services/password_service.dart';
import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/clipboard_manager.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:get/get.dart';

class LoginDetailsController extends GetxController {
  RxBool showPassword = false.obs;
  RxBool favorite = false.obs;
  Login _login;

  @override
  void onInit() {
    _login = Get.arguments;
    favorite.value = _login?.favorite;
    super.onInit();
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void onCopyClick(String data, int type) async {
    final clipboardManager = ClipBoardManager();
    clipboardManager.copyToClipboard(data);
    String msg = type == 0 ? USERNAME_COPIED : PASSWORD_COPIED;
    AppSnackBar.show(Get.context, text: msg);
  }

  int getScore(String password) {
    return PasswordService.calculateScore(password).ceil();
  }

  void toggleFavorite() async {
    favorite.toggle();
    Map<String, dynamic> payload = _login.toMap();
    payload["favorite"] = favorite.value;
    _login.update(payload);

    await DBHelper.instance.updateOne(_login.id, _login.toMap());
  }
}
