import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final _databaseName = "cryptokeep.db";
  static final _databaseVersion = 1;

  static final loginTable = "password_table";

  static final _id = "_id";
  static final _title = "title";
  static final _username = "username";
  static final _password = "password";
  static final _category = "category";
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
      CREATE TABLE $loginTable (
        $_id TEXT PRIMARY KEY,
        $_title TEXT NOT NULL,
        $_username TEXT NOT NULL,
        $_password TEXT NOT NULL,
        $_category TEXT,
        $_createdAt TEXT,
        $_updatedAt TEXT
      )
    ''');
  }

  /// Purge
  Future deleteAll() async {
    var db = await instance.database;
    return db.delete(loginTable);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    var db = await instance.database;
    return await db.query(loginTable);
  }

  Future<List<Map<String, dynamic>>> find({search, projection}) async {
    var db = await instance.database;
    return await db
        .query(loginTable, where: "$_title LIKE ?", whereArgs: ["%$search%"]);
  }

  Future<int> insertOne(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(loginTable, row);
  }

  Future<int> deleteByID(String id) async {
    var db = await instance.database;
    return await db.delete(loginTable, where: "$_id = ?", whereArgs: [id]);
  }

  Future<int> updateOne(String id, Map<String, dynamic> row) async {
    print(row);
    var db = await instance.database;
    return await db.update(
      loginTable,
      row,
      where: "$_id = ?",
      whereArgs: [id],
    );
  }
}
