import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/features/cart_page/cart_page_app_bar/cart_page_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/cart_item_view.dart';
import '../../router/app_routes.dart';
import '../../services/cart_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cart = context.watch<CartService>();
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    if (cart.isEmpty) {
      return Scaffold(
        appBar: const CartPageAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: 96,
              ),
              const SizedBox(height: 24),
              Text(
                l10n.emptyCart,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.addProductsToStart,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: color.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const CartPageAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cart.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return _CartItemCard(item: item);
              },
            ),
          ),
          _CartSummary(),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItemView item;

  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartService>();
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final lineTotal = item.product.price * item.quantity;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.product.productImage.url,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.product.category.name,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: color.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '€${lineTotal.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: color.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () => cart.add(item.product),
                  icon: const Icon(Icons.add_circle_outline),
                ),
                Text(
                  '${item.quantity}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => cart.decrement(item.product),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cart = context.watch<CartService>();
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final subtotal = cart.items.fold<double>(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    const shipping = 4.99;
    final total = subtotal + shipping;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryRow(label: l10n.subtotal, value: subtotal),
            const SizedBox(height: 8),
            _SummaryRow(label: l10n.shipping, value: shipping),
            const Divider(height: 24),
            _SummaryRow(
              label: l10n.total,
              value: total,
              isTotal: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => context.go(AppRoutes.checkout.path),
                child: Text(
                  l10n.proceedToCheckout,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: color.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = isTotal
        ? theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          )
        : theme.textTheme.bodyLarge;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('€${value.toStringAsFixed(2)}', style: style),
      ],
    );
  }
}
