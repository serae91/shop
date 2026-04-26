import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../router/app_routes.dart';
import '../../../services/cart_service.dart';
import '../../../services/theme_service.dart';

class ShopPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopPageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = Theme.of(context).colorScheme;
    final cart = context.watch<CartService>();
    print('l10n.appTitle');
    print(l10n.appTitle);

    return AppBar(
      iconTheme: IconThemeData(
        color: color.onSurface,
      ),
      backgroundColor: color.surface,
      elevation: 0,
      title: Text(
        l10n.appTitle,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color.onSurface,
            ),
      ),
      actions: [
        IconButton(
          tooltip: 'Shopping Cart',
          onPressed: () => context.go(AppRoutes.cart.path),
          icon: Badge(
            isLabelVisible: cart.totalQuantity > 0,
            label: Text('${cart.totalQuantity}'),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
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
