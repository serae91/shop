import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/login_page.dart';
import '../features/cart_page/cart_page.dart';
import '../features/checkout_page/checkout_page.dart';
import '../features/shop_page/shop_page.dart';
import '../services/auth_service.dart';
import 'app_routes.dart';

class AppRouter {
  final AuthService auth;

  AppRouter(this.auth);

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.shop.path,
    refreshListenable: auth,
    redirect: (context, state) {
      final route = AppRoutes.findByPath(state.matchedLocation);
      final isLoggedIn = auth.isLoggedIn;

      if (route == null) return null;

      if (route.requiresAuth && !isLoggedIn) {
        final redirect = Uri.encodeComponent(state.uri.toString());
        return '${AppRoutes.login.path}?redirect=$redirect';
      }

      if (isLoggedIn && route.path == AppRoutes.login.path) {
        final target = state.uri.queryParameters['redirect'];
        if (target != null && target.isNotEmpty) {
          return Uri.decodeComponent(target);
        }
        return AppRoutes.shop.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.shop.path,
        name: AppRoutes.shop.name,
        builder: (_, __) => const ShopPage(),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.cart.path,
        name: AppRoutes.cart.name,
        builder: (_, __) => const CartPage(),
      ),
      GoRoute(
        path: AppRoutes.checkout.path,
        name: AppRoutes.checkout.name,
        builder: (_, __) => const CheckoutPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Seite nicht gefunden')),
      body: Center(
        child: Text('Keine Route für: ${state.uri}'),
      ),
    ),
  );
}
