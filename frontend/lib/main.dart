import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/services/cart_service.dart';
import 'package:frontend/services/dio_client.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';
import 'services/api_services.dart';
import 'services/auth_service.dart';
import 'services/locale_service.dart';
import 'services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final auth = AuthService();
  await auth.loadToken();

  DioClient.init(auth);

  runApp(MyApp(auth: auth));
}

class MyApp extends StatelessWidget {
  final AuthService auth;
  late final GoRouter _router = AppRouter(auth).router;

  MyApp({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => ApiService(),
        ),
        ChangeNotifierProvider.value(
          value: auth,
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeService(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartService(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => LocaleService(),
        ),
      ],
      child: _AppRoot(router: _router),
    );
  }
}

class _AppRoot extends StatelessWidget {
  final GoRouter router;

  const _AppRoot({
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeService>();
    final localeService = context.watch<LocaleService>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: localeService.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: theme.mode,
    );
  }
}
