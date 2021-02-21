import 'package:uuid/uuid.dart';

class Password {
  String id, username, password, title, createdAt, updatedAt;

  Password({id, name, username, password, createdAt, updatedAt}) {
    this.id = id ?? Uuid().v4().toString();
    this.title = name;
    this.username = username;
    this.password = password;
    this.createdAt = createdAt ?? DateTime.now().toIso8601String();
    this.updatedAt = updatedAt ?? DateTime.now().toIso8601String();
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "_id": this.id,
      "title": this.title,
      "username": this.username,
      "password": this.password,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt
    };
    return map;
  }

  Password.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    title = map["title"];
    username = map["username"];
    password = map["password"];
    createdAt = map["createdAt"];
    updatedAt = map["updatedAt"];
  }

  /// Create object with essentials only ///
  static Password fromValue(Map<String, dynamic> map) {
    return Password(
      name: map["title"],
      username: map["username"],
      password: map["password"],
    );
  }

  void update(Map<String, dynamic> value) {
    /// TODO: Remove or operation ///
    this.title = value["title"];
    this.username = value["username"];
    this.password = value["password"];
  }
}
