import 'app_route_config.dart';

class AppRoutes {
  static const shop = AppRouteConfig(
    path: '/shop',
    name: 'shop',
  );

  static const login =
      AppRouteConfig(path: '/login', name: 'login', requiresShop: true);

  static const cart = AppRouteConfig(
      path: '/cart', name: 'cart', requiresAuth: true, requiresShop: true);

  static const checkout = AppRouteConfig(
    path: '/checkout',
    name: 'checkout',
    requiresAuth: true,
    requiresShop: true,
  );

  static const all = [
    shop,
    login,
    cart,
    checkout,
  ];

  static AppRouteConfig? findByPath(String path) {
    try {
      return all.firstWhere((route) => route.path == path);
    } catch (_) {
      return null;
    }
  }
}
