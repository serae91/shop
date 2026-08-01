import 'package:flutter/foundation.dart';
import 'package:frontend/model/cart_item_view.dart';
import 'package:frontend/model/cart_view.dart';

import '../model/product_view.dart';
import 'api_services.dart';

class CartService extends ChangeNotifier {
  final ApiService _api;

  CartService(this._api);

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

  Future<void> add(ProductView product, {int quantity = 1}) async {
    final previousCart = _cart;

    _addLocally(product, quantity: quantity);

    try {
      final updatedCart = await _api.addToCart(product.id, quantity);
      print(updatedCart);
      _cart = updatedCart;
      notifyListeners();
    } catch (e) {
      _cart = previousCart;
      notifyListeners();
      rethrow;
    }
  }

  void _addLocally(ProductView product, {int quantity = 1}) {
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

  Future<void> decrement(ProductView product, {int quantity = 1}) async {
    final previousCart = _cart;

    _decrementLocally(product, quantity: quantity);

    try {
      final updatedCart = await _api.updateCartItem(
        product.id,
        quantityFor(product.id),
      );
      _cart = updatedCart;
      notifyListeners();
    } catch (e) {
      _cart = previousCart;
      notifyListeners();
      rethrow;
    }
  }

  void _decrementLocally(ProductView product, {int quantity = 1}) {
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
