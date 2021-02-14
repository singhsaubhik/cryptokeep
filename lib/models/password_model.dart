import 'package:uuid/uuid.dart';

class Password {
  String id, username, password, name, createdAt, updatedAt;

  Password({id, name, username, password, createdAt, updatedAt}) {
    this.id = id ?? Uuid().v4().toString();
    this.name = name;
    this.username = username;
    this.password = password;
    this.createdAt = createdAt ?? DateTime.now().toIso8601String();
    this.updatedAt = updatedAt ?? DateTime.now().toIso8601String();
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "_id": this.id,
      "name": this.name,
      "username": this.username,
      "password": this.password,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt
    };
    return map;
  }

  Password.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    name = map["name"];
    username = map["username"];
    password = map["password"];
    createdAt = map["createdAt"];
    updatedAt = map["updatedAt"];
  }
}
