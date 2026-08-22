import 'package:flutter/material.dart';
import 'package:openidconnect/openidconnect.dart';

import '../token_storage.dart';

class AuthService extends ChangeNotifier {
  String? token;

  bool get isLoggedIn => token != null && token!.isNotEmpty;

  static const String discoveryUrl =
      'http://localhost:8180/realms/shop/.well-known/openid-configuration';

  static const String clientId = 'shop-frontend';

  static const String redirectUrl = 'http://localhost:3000/callback.html';

  static Future<OpenIdConfiguration> loadConfiguration() async {
    return OpenIdConnect.getConfiguration(discoveryUrl);
  }

  Future<void> initialize() async {
    try {
      final configuration = await loadConfiguration();

      final response = await OpenIdConnect.processStartup(
        clientId: clientId,
        redirectUrl: redirectUrl,
        scopes: const [
          'openid',
          'profile',
          'email',
        ],
        configuration: configuration,
        autoRefresh: false,
      );

      if (response != null) {
        await setToken(response.accessToken);
      }
    } catch (e, stackTrace) {
      print('AUTH ERROR STACKTRACE: $stackTrace');
    }

    final storedToken = await TokenStorage.getToken();

    if (token == null && storedToken != null) {
      token = storedToken;
    }

    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    final configuration = await loadConfiguration();

    final request = await InteractiveAuthorizationRequest.create(
      clientId: clientId,
      redirectUrl: redirectUrl,
      scopes: const [
        'openid',
        'profile',
        'email',
      ],
      configuration: configuration,
      autoRefresh: false,
      useWebPopup: false,
    );

    final response = await OpenIdConnect.authorizeInteractive(
      context: context,
      title: 'Login',
      request: request,
    );

    if (response == null) {
      return;
    }

    await setToken(response.accessToken);

    print('=== LOGIN COMPLETE ===');
  }

  Future<void> setToken(String newToken) async {
    if (newToken.isEmpty) {
      return;
    }

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
