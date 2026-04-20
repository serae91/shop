import 'package:flutter/material.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/dio_client.dart';
import 'package:frontend/services/theme_service.dart';
import 'package:provider/provider.dart';

import 'auth_gate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider<ApiService>(create: (_) => ApiService()), // ✅ DAS FEHLT
      ],
      child: const AppRoot(),
    );
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final auth = context.read<AuthService>();
    DioClient.init(auth);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeService>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: theme.mode,
      home: const AuthGate(),
    );
  }
}