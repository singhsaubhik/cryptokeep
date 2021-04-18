import 'package:cryptokeep/utils/encryption.dart';
import 'package:uuid/uuid.dart';

class Login {
  String id, username, password, category, title, createdAt, updatedAt;
  bool favorite;

  Login({
    id,
    name,
    username,
    password,
    category = "Login",
    createdAt,
    updatedAt,
    favorite = false,
  }) {
    this.id = id ?? Uuid().v4().toString();
    this.title = name;
    this.username = username;
    this.password = password;
    this.category = category;
    this.favorite = favorite;
    this.createdAt = createdAt ?? DateTime.now().toIso8601String();
    this.updatedAt = updatedAt ?? DateTime.now().toIso8601String();
  }

  Map<String, dynamic> toMap({bool favoriteAsBool = false}) {
    var map = <String, dynamic>{
      "_id": this.id,
      "title": this.title,
      "username": this.username,
      "password": this.password,
      "category": this.category,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
      "favorite": this.favorite ? 1 : 0,
    };

    if(favoriteAsBool){
      map["favorite"] = this.favorite;
    }

    return map;
  }

  Login.fromMap(Map<String, dynamic> map, {decryptPassword = false}) {
    id = map["_id"];
    title = map["title"];
    username = map["username"];
    password = decryptPassword
        ? EncryptionService().decrypt(map["password"])
        : map["password"];
    category = map["category"];
    createdAt = map["createdAt"];
    updatedAt = map["updatedAt"];
    favorite = map["favorite"] == 0 ? false : true;
  }

  /// Create object with essentials only ///
  static Login fromValue(Map<String, dynamic> map) {
    return Login(
      name: map["title"],
      username: map["username"],
      password: map["password"],
      category: map["category"],
      favorite: map["favorite"] == 0 ? false : true,
    );
  }

  void update(Map<String, dynamic> value) {
    this.title = value["title"];
    this.username = value["username"];
    this.password = value["password"];
    this.category = value["category"] ?? this.category;
    this.favorite = value["favorite"] ?? this.favorite;
  }
}
