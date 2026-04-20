import 'package:flutter/material.dart';
import '../token_storage.dart';

class AuthService extends ChangeNotifier {
  String? token;

  bool get isLoggedIn => token != null;

  Future<void> loadToken() async {
    token = await TokenStorage.getToken();
    notifyListeners();
  }

  Future<void> setToken(String newToken) async {
    token = newToken;
    await TokenStorage.saveToken(newToken);
    notifyListeners();
  }

  Future<void> logout() async {
    token = null;
    await TokenStorage.clear();
    notifyListeners();
  }
}