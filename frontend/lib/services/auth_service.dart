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
    print('=== AUTH INITIALIZE ===');

    try {
      final configuration = await loadConfiguration();

      print('=== PROCESS STARTUP ===');

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

      print('=== PROCESS STARTUP RESULT ===');
      print('RESPONSE: $response');

      if (response != null) {
        print('=== STARTUP LOGIN SUCCESS ===');
        print('ACCESS TOKEN: ${response.accessToken}');

        await setToken(response.accessToken);

        print('=== STARTUP TOKEN SAVED ===');
      }
    } catch (e, stackTrace) {
      print('=== PROCESS STARTUP ERROR ===');
      print('ERROR: $e');
      print('STACKTRACE: $stackTrace');
    }

/*
     * ---------------------------------------------------------
     * 2. GESPEICHERTEN TOKEN LADEN
     * ---------------------------------------------------------
     */
    print('=== LOAD STORED TOKEN ===');

    final storedToken = await TokenStorage.getToken();

    print(
      'STORED TOKEN: '
      '${storedToken == null ? 'null' : '${storedToken.substring(0, storedToken.length > 20 ? 20 : storedToken.length)}...'}',
    );

/*
     * Falls processStartup() keinen neuen Token gesetzt hat,
     * verwenden wir den gespeicherten Token.
     */
    if (token == null && storedToken != null) {
      token = storedToken;
    }

    print('FINAL TOKEN EXISTS: ${token != null}');
    print('FINAL LOGGED IN: $isLoggedIn');

    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    print('=== LOGIN START ===');

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

    print('=== AUTH REQUEST CREATED ===');
    print('REDIRECT URL: ${request.redirectUrl}');

/*
     * Bei useWebPopup:false wird der Browser zu Keycloak
     * weitergeleitet.
     *
     * Nach erfolgreichem Login lädt Flutter die Anwendung
     * unter redirectUrl erneut.
     *
     * Deshalb wird der eigentliche Code-Austausch anschließend
     * in initialize() -> processStartup() durchgeführt.
     */
    final response = await OpenIdConnect.authorizeInteractive(
      context: context,
      title: 'Login',
      request: request,
    );

    print('=== AUTHORIZE INTERACTIVE RETURNED ===');
    print('RESPONSE: $response');

/*
     * Bei Redirect-Loop kann response null sein, weil die Seite
     * zwischenzeitlich verlassen wurde.
     */
    if (response == null) {
      print(
        '=== AUTHORIZE RETURNED NULL '
        '(NORMAL FOR REDIRECT FLOW) ===',
      );
      return;
    }

/*
     * Falls das Package trotzdem direkt einen Response liefert.
     */
    await setToken(response.accessToken);

    print('=== LOGIN COMPLETE ===');
  }

  Future<void> setToken(String newToken) async {
    print('=== SET TOKEN ===');

    if (newToken.isEmpty) {
      print('WARNING: EMPTY TOKEN');
      return;
    }

    token = newToken;

    await TokenStorage.saveToken(newToken);

    final storedToken = await TokenStorage.getToken();

    print('TOKEN SET: ${token != null}');
    print('TOKEN STORAGE EXISTS: ${storedToken != null}');

    notifyListeners();
  }

  Future<void> logout() async {
    print('=== LOGOUT ===');

    token = null;

    await TokenStorage.clear();

    print('TOKEN CLEARED');
    print('LOGGED IN: $isLoggedIn');

    notifyListeners();
  }
}
