import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final color = Theme.of(context).colorScheme;

    return AppBar(
      iconTheme: IconThemeData(
        color: color.onSurface,
      ),
      backgroundColor: color.surface,
      elevation: 0,
      title: Text(
        l10n.cartTitle,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color.onSurface,
            ),
      ),
      actions: [
        IconButton(
          tooltip: l10n.appTitle,
          onPressed: () => context.go(AppRoutes.shop.path),
          icon: const Icon(Icons.shop),
        ),
        IconButton(
          tooltip: l10n.toggleTheme,
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
