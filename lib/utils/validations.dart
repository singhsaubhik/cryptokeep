import 'package:cryptokeep/exceptions/validation_exceptions.dart';
import 'package:cryptokeep/models/login_model.dart';

void validateLogin(Login login) {
  /// TODO: Add better validations with regex and etc..
  if (login.id == null) {
    throw ValidationError(id: login.title, cause: "Invalid ID is provided");
  }
}
