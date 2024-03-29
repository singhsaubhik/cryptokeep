import 'package:encrypt/encrypt.dart';

/// Provide ENCRYPTION_KEY as env
const _key = String.fromEnvironment(
  "ENCRYPTION_KEY",
  defaultValue: "kjkDSAFS34234SDFSXSWWWqaSwerty67",
);

class EncryptionService {
  final _encryptionKey = Key.fromUtf8(_key);
  final _iv = IV.fromLength(16);
  Encrypter _encrypter;

  EncryptionService() {
    this._encrypter = Encrypter(AES(_encryptionKey));
  }

  String encrypt(String data) {
    return _encrypter.encrypt(data, iv: _iv).base64;
  }

  String decrypt(String data) {
    return this._encrypter.decrypt64(data, iv: _iv);
  }
}
