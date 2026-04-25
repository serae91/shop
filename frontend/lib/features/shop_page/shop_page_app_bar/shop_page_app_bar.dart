import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/theme_service.dart';

class ShopPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopPageAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: color.surface,
      elevation: 0,
      title: const Text(
        "Shop",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
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
