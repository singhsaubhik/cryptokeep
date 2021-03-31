import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/clipboard_manager.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:get/get.dart';

class LoginDetailsController extends GetxController {
  RxBool showPassword = false.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void onCopyClick(String data, int type) async {
    final clipboardManager = ClipBoardManager();
    clipboardManager.copyToClipboard(data);
    String msg = type == 0 ? USERNAME_COPIED : PASSWORD_COPIED;
    AppSnackBar.show(Get.context, text: msg);
  }
}
