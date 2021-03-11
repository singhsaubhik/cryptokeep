import 'package:cryptokeep/exceptions/validation_exceptions.dart';
import 'package:cryptokeep/models/login_model.dart';

void validateLogin(Login login) {
  /// TODO: Add better validations with regex and etc..
  if (login.id == null) {
    throw ValidationError(id: login.title, cause: "Invalid ID is provided");
  }
}

// Email validation function for the form
String validateEmail(String email) {
  // Email expression
  RegExp regex = RegExp(r'\w+@\w+\.\w+');

  // Return an error string
  // if the string is empty or it is not an email
  if (email.isEmpty)
    return "Please enter a value";
  else if (!regex.hasMatch(email))
    return "Please enter a valid email";
  else
    return null;
}

// Password validation function for the form
String validatePassword(String password) {
  // Uppercase expression
  RegExp hasUpper = RegExp(r'[A-Z]');
  // Lowercase expression
  RegExp hasLower = RegExp(r'[a-z]');
  // Digit expression
  RegExp hasDigit = RegExp(r'\d');
  // Punctuation expression
  RegExp hasPunct = RegExp(r'[!@#\$&*~-]');

  String error = "";
  // Return an error string if the password does not have the following
  //    At least 8 characters
  //    At least one upper case
  //    At least one lower case
  //    At least one number
  //    At least one special
  if (password.isEmpty) {
    error = "Please enter a value";
    return error;
  } else if (!RegExp(r'.{8,}').hasMatch(password) ||
      !hasUpper.hasMatch(password) ||
      !hasLower.hasMatch(password) ||
      !hasDigit.hasMatch(password) ||
      !hasPunct.hasMatch(password)) {
    error = "Please satisfy the following conditions:\n";
    if (!RegExp(r'.{8,}').hasMatch(password))
      error += '\tPasswords must have at least 8 characters\n';
    if (!hasUpper.hasMatch(password))
      error += '\tPasswords must have at least one uppercase character\n';
    if (!hasLower.hasMatch(password))
      error += '\tPasswords must have at least one lowercase character\n';
    if (!hasDigit.hasMatch(password))
      error += '\tPasswords must have at least one number\n';
    if (!hasPunct.hasMatch(password))
      error +=
          '\tPasswords need at least one special character like !@#\$&*~-\n';
    return error;
  } else
    return null;
}
