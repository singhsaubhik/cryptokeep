import 'package:flutter/cupertino.dart';

class ValidationError implements Exception {
  String cause;
  String id;

  ValidationError({@required this.id, @required this.cause});
}
