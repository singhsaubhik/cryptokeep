import 'package:cryptokeep/services/password_service.dart';
import 'package:cryptokeep/utils/app_snackbar.dart';
import 'package:cryptokeep/utils/clipboard_manager.dart';
import 'package:get/get.dart';

class PasswordGeneratorController extends GetxController {
  var password = "12345678".obs;
  var passwordLength = 8.0.obs;
  var upperCase = false.obs;
  var lowerCase = false.obs;
  var specialLetters = false.obs;
  var digits = true.obs;

  void setUppercase(bool v) => upperCase.value = v;

  void setLowercase(bool v) => lowerCase.value = v;

  void setSpecialLetters(bool v) => specialLetters.value = v;

  void setDigits(bool v) => digits.value = v;

  void setPasswordLength(double v) => passwordLength.value = v.ceilToDouble();

  void generatePassword() {
    if (upperCase.value == false &&
        lowerCase.value == false &&
        digits.value == false) {
      return AppSnackBar.show(
        Get.context,
        text: "At least widget should be enabled to generate password",
      );
    }

    final passwordService = PasswordService(
      isCaps: upperCase.value,
      isSmall: lowerCase.value,
      isNumber: digits.value,
      isSpecialChars: specialLetters.value,
    );

    final pass = passwordService.generate(length: passwordLength.floor());
    password.value = pass;
  }

  void onCopyClick() {
    ClipBoardManager().copyToClipboard(this.password.value);
    AppSnackBar.show(Get.context, text: "Copied to clipboard");
  }
}
