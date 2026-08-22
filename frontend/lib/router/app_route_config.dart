class AppRouteConfig {
  final String path;
  final String name;
  final bool requiresAuth;
  final bool requiresShop;

  const AppRouteConfig({
    required this.path,
    required this.name,
    this.requiresAuth = false,
    this.requiresShop = false,
  });
}
