import 'dart:math';

class PasswordService {
  static const _kSpecialChars = "@#\$%&!<>~^(){}|?";
  static const _numbers = "0123456789";
  static const _smallLetters = "abcdefghijklmnopqrstuvwxyz";
  static final _capitalLetters = _smallLetters.toUpperCase();

  bool isNumber, isCaps, isSmall, isSpecialChars;

  PasswordService({
    this.isNumber = true,
    this.isCaps = true,
    this.isSmall = true,
    this.isSpecialChars = true,
  });

  String _passGen(int length) {
    String result = "";
    String string = _numbers;

    /// TODO: Shuffle the order

    if (this.isSmall) string += _smallLetters;
    if (this.isCaps) string += _capitalLetters;
    if (this.isSpecialChars) string += _kSpecialChars;

    for (int i = 0; i < length; i++) {
      int rand = Random.secure().nextInt(string.length - 1);
      result += string[rand];
    }

    return result;
  }

  String generate({int length = 8}) {
    String result = _passGen(length);

    /// Check if all checked characters are present
    while (true) {
      if (this.isNumber && !result.contains(RegExp(r'[0-9]'))) {
        result = _passGen(length);
      } else if (this.isSmall && !result.contains(RegExp(r'[a-z]'))) {
        result = _passGen(length);
      } else if (this.isCaps && !result.contains(RegExp(r'[A-Z]'))) {
        result = _passGen(length);
      } else if (this.isSpecialChars &&
          !result.contains(RegExp(r'[@#\$%&!<>~^(){}|?]'))) {
        result = _passGen(length);
      } else {
        break;
      }
    }

    return result;
  }
}
