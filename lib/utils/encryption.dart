import 'package:encrypt/encrypt.dart';

class EncryptionService {
  final _encryptionKey = Key.fromUtf8("kjkDSAFS34234SDFSXSWWWqaSwerty67");
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
