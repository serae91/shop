import 'package:flutter/material.dart';
import 'package:frontend/model/product_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../model/cart_item_view.dart';
import '../../../router/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/cart_service.dart';

class ShopPageProduct extends StatelessWidget {
  final ProductView product;

  const ShopPageProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartService>();
    final quantity = cart.quantityFor(product.id);
    final color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Image.network(
                product.productImage.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.category.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: color.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "€${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color.primary,
                      ),
                    ),
                    Text('In Cart: ${quantity}'),
                    Container(
                      decoration: BoxDecoration(
                        color: color.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.remove, size: 18),
                        color: color.onPrimary,
                        onPressed: () {
                          cart.removeProduct(product.id, 1);
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: color.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, size: 18),
                        color: color.onPrimary,
                        onPressed: () {
                          final auth = context.read<AuthService>();

                          if (!auth.isLoggedIn) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Login required"),
                                content: const Text(
                                  "You need to login to add products to the cart.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      context.go(AppRoutes.login.path);
                                    },
                                    child: const Text("Login"),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }
                          context.read<CartService>().addProduct(
                                CartItemView(
                                  id: 0,
                                  product: product,
                                  quantity: 1,
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
