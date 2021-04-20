import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalPath {
  LocalPath._privateConstructor();
  static final LocalPath instance = LocalPath._privateConstructor();
  final String path = "assets";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final rootPath = await _localPath;
    return File('$rootPath/loginData.json');
  }

  Future<List<dynamic>> readData() async {
    try {
      final file = await _localFile;

      // Read the file
      String readContent = await file.readAsString();

      try {
        var data = await json.decode(readContent);
        return data;
      } catch (error) {
        print(error);
        return null;
      }
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writeData(List<Map<String, dynamic>> list) async {
    final file = await _localFile;
    String writeContent = jsonEncode(list);

    // Write the file
    return file.writeAsString(writeContent);
  }
}
