import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AppAuthentication {
  LocalAuthentication _auth;

  AppAuthentication() {
    _auth = LocalAuthentication();
  }

  Future<bool> initAuth() async {
    var canIuse = await this.__checkBiometrics();
    var isAuthenticated = false;
    if (canIuse) {
      isAuthenticated = await this._authenticate();
    }
    return isAuthenticated;
  }

  Future<bool> __checkBiometrics() async {
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await this._auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    //  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }

    return canCheckBiometrics;
  }

  Future<bool> _authenticate() async {
    bool response = false;
    try {
      response = await this._auth.authenticateWithBiometrics(
            localizedReason: 'Scan your fingerprint to authenticate',
            useErrorDialogs: true,
            stickyAuth: true,
          );
    } on PlatformException catch (e) {
      print(e);
      return false;
    }

    return response;
  }

  void cancelAuthentication() {
    this._auth.stopAuthentication();
  }
}
