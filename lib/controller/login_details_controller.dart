import 'package:cryptokeep/controller/home_controller.dart';
import 'package:cryptokeep/models/login_model.dart';
import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/clipboard_manager.dart';
import 'package:cryptokeep/utils/constants.dart';
import 'package:get/get.dart';

class LoginDetailsController extends GetxController {
  RxBool showPassword = false.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void onEditClick(Login login) {
    print(login.title);
  }

  Login getLoginById() {
    final homeController = Get.find<HomeController>();
    final String id = Get.routing.args;
    return homeController.getItemById(id);
  }

  void onCopyClick(String data, int type) {
    ClipBoardManager().copyToClipboard(data);
    String msg = type == 0 ? USERNAME_COPIED : PASSWORD_COPIED;
    AppSnackBar.show(Get.context, text: msg);
  }
}
