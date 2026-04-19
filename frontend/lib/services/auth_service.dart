import 'package:flutter/material.dart';
import '../token_storage.dart';
import 'dio_client.dart';

class AuthService extends ChangeNotifier {
  String? token;

  Future<void> loadToken() async {
    token = await TokenStorage.getToken();

    if (token != null) {
      DioClient.setToken(token!);
    }

    notifyListeners();
  }

  Future<void> login(String newToken) async {
    token = newToken;

    await TokenStorage.saveToken(newToken);
    DioClient.setToken(newToken);

    notifyListeners();
  }

  Future<void> logout() async {
    token = null;

    await TokenStorage.clear();
    DioClient.clearToken();

    notifyListeners();
  }

  bool get isLoggedIn => token != null;
}