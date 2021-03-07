import 'package:flutter/cupertino.dart';

class User {
  String fullName, email, masterPassword;

  User({
    @required this.fullName,
    @required this.email,
    @required this.masterPassword,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "fullName": this.fullName,
      "email": this.email,
      "masterPassword": this.masterPassword,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    fullName = map["fullName"];
    email = map["email"];
    masterPassword = map["masterPassword"];
  }
}
