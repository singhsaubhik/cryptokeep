import 'package:encrypt/encrypt.dart';

// Create a key for encryption
final key = Key.fromUtf8('my 32 length key................');
// IV
final iv = IV.fromLength(16);
// Create encrypter
final encrypter =
    Encrypter(AES(Key.fromUtf8('my 32 length key................')));

// Encrypt password in the row
Map<String, dynamic> encryptRow(Map<String, dynamic> row) {
  row["password"] = encrypter.encrypt(row["password"], iv: iv).base64;
  print("Encrypted password: " + row["password"]);
  return row;
}
