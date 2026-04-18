import '../token_storage.dart';

class AuthService {
  String? token;

  Future<void> loadToken() async {
    token = await TokenStorage.getToken();
  }

  Future<void> login(String newToken) async {
    token = newToken;
    await TokenStorage.saveToken(newToken);
  }

  Future<void> logout() async {
    token = null;
    await TokenStorage.clear();
  }

  bool get isLoggedIn => token != null;
}