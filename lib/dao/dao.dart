import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final _databaseName = "cryptokeep.db";
  static final _databaseVersion = 1;

  static final passwordTable = "password_table";

  static final _id = "_id";
  static final _name = "name";
  static final _username = "username";
  static final _password = "password";
  static final _createdAt = "createdAt";
  static final _updatedAt = "updatedAt";

  DBHelper._privateConstructor();

  static final DBHelper instance = DBHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String path = join(_directory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $passwordTable (
        $_id TEXT PRIMARY KEY,
        $_name TEXT NOT NULL,
        $_username TEXT,
        $_password TEXT NOT NULL,
        $_createdAt TEXT,
        $_updatedAt TEXT
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    var db = await instance.database;
    return await db.query(passwordTable);
  }

  Future<List<Map<String, dynamic>>> find({search, projection}) async {
    var db = await instance.database;
    return await db
        .query(passwordTable, where: "$_name LIKE ?", whereArgs: ["%$search%"]);
  }

  Future<int> insertOne(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(passwordTable, row);
  }

  Future<int> deleteByID(String id) async{
    var db = await instance.database;
    return await db.delete(passwordTable, where: "$_id = ?", whereArgs: [id]);
  }
}
