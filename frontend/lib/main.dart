import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';
import 'services/api_services.dart';
import 'services/auth_service.dart';
import 'services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final auth = AuthService();
  await auth.loadToken();

  runApp(MyApp(auth: auth));
}

class MyApp extends StatelessWidget {
  final AuthService auth;

  const MyApp({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(auth).router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: auth),
        ChangeNotifierProvider(create: (_) => ThemeService()),
        Provider(create: (_) => ApiService()),
      ],
      child: Builder(
        builder: (context) {
          final theme = context.watch<ThemeService>();

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: theme.mode,
          );
        },
      ),
    );
  }
}
