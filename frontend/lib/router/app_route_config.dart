class AppRouteConfig {
  final String path;
  final String name;
  final bool requiresAuth;

  const AppRouteConfig({
    required this.path,
    required this.name,
    this.requiresAuth = false,
  });
}
