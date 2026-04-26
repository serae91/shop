import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../router/app_routes.dart';
import '../../../services/theme_service.dart';

class CartPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartPageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: color.surface,
      elevation: 0,
      title: const Text(
        'Shopping Cart',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          tooltip: 'Shop',
          onPressed: () => context.go(AppRoutes.shop.path),
          icon: const Icon(Icons.shop),
        ),
        IconButton(
          tooltip: 'Toggle Theme',
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
          onPressed: () => context.read<ThemeService>().toggle(),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
