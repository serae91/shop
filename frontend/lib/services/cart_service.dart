import 'package:flutter/foundation.dart';
import 'package:frontend/model/cart_item_view.dart';
import 'package:frontend/model/cart_view.dart';

import '../model/product_view.dart';

class CartService extends ChangeNotifier {
  CartView? _cart;

  CartView? get cart => _cart;

  List<CartItemView> get items => _cart?.cartItems ?? [];

  bool get isEmpty => items.isEmpty;

  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  int quantityFor(int productId) {
    final item = items.where((e) => e.product.id == productId).firstOrNull;
    return item?.quantity ?? 0;
  }

  void setCart(CartView cart) {
    _cart = cart;
    notifyListeners();
  }

  void clear() {
    _cart = null;
    notifyListeners();
  }

  void add(ProductView product, {int quantity = 1}) {
    final updatedItems = List<CartItemView>.from(items);

    final index = updatedItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      final existing = updatedItems[index];
      updatedItems[index] = CartItemView(
        id: existing.id,
        product: existing.product,
        quantity: existing.quantity + quantity,
      );
    } else {
      updatedItems.add(
        CartItemView(
          id: 0,
          product: product,
          quantity: quantity,
        ),
      );
    }

    _updateCart(updatedItems);
  }

  void decrement(ProductView product, {int quantity = 1}) {
    final updatedItems = List<CartItemView>.from(items);

    final index = updatedItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) return;

    final existing = updatedItems[index];

    if (existing.quantity > quantity) {
      updatedItems[index] = CartItemView(
        id: existing.id,
        product: existing.product,
        quantity: existing.quantity - quantity,
      );
    } else {
      updatedItems.removeAt(index);
    }

    _updateCart(updatedItems);
  }

  void _updateCart(List<CartItemView> updatedItems) {
    _cart = CartView(
      id: _cart?.id ?? 0,
      createdAt: _cart?.createdAt ?? DateTime.now(),
      cartItems: updatedItems,
    );
    notifyListeners();
  }
}
