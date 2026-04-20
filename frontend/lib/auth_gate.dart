import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/shop_page/shop_page.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final auth = context.read<AuthService>();
    final api = context.read<ApiService>();

    await auth.loadToken();

    if (auth.isLoggedIn) {
      try {
        await api.getMe();
      } catch (_) {
        await auth.logout();
      }
    }

    if (!mounted) return;

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (auth.isLoggedIn) {
      return const ShopPage();
    }

    return const LoginPage();
  }
}