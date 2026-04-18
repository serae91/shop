import 'package:flutter/material.dart';

import 'services/auth_service.dart';
import 'login_page.dart';
import 'home_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final auth = AuthService();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await auth.loadToken();

    if (mounted) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return auth.isLoggedIn ? const HomePage() : const LoginPage();
  }
}