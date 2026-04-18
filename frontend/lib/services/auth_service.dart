import 'package:flutter/material.dart';
import '../token_storage.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? token;

  Future<void> loadToken() async {
    token = await TokenStorage.getToken();
    notifyListeners();
  }

  Future<void> login(String newToken) async {
    token = newToken;
    await TokenStorage.saveToken(newToken);
    notifyListeners(); // 🔥 wichtig!
  }

  Future<void> logout() async {
    token = null;
    await TokenStorage.clear();
    notifyListeners(); // 🔥 wichtig!
  }

  bool get isLoggedIn => token != null;
}