import 'package:flutter/foundation.dart';
import 'package:frontend/model/cart_item_view.dart';
import 'package:frontend/model/cart_view.dart';

class CartService extends ChangeNotifier {
  CartView? _cart;

  CartView? get cart => _cart;

  bool get isEmpty => _cart == null || _cart!.cartItems.isEmpty;

  List<CartItemView> get items => _cart?.cartItems ?? [];

  int get totalQuantity {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  int quantityFor(int productId) {
    final item = items.where((e) => e.product.id == productId).firstOrNull;
    return item?.quantity ?? 0;
  }

  void setCart(CartView cart) {
    _cart = cart;
    notifyListeners();
  }

  void addProduct(CartItemView newItem) {
    if (_cart == null) {
      _cart = CartView(
        id: 0,
        createdAt: DateTime.now(),
        cartItems: [newItem],
      );
      notifyListeners();
      return;
    }

    final items = List<CartItemView>.from(_cart!.cartItems);

    final index = items.indexWhere(
      (e) => e.product.id == newItem.product.id,
    );

    if (index >= 0) {
      final existing = items[index];
      items[index] = CartItemView(
        id: existing.id,
        product: existing.product,
        quantity: existing.quantity + newItem.quantity,
      );
    } else {
      items.add(newItem);
    }

    _cart = CartView(
      id: _cart!.id,
      createdAt: _cart!.createdAt,
      cartItems: items,
    );

    notifyListeners();
  }

  void removeProduct(int productId) {
    if (_cart == null) return;

    final items = List<CartItemView>.from(_cart!.cartItems);

    final index = items.indexWhere(
      (e) => e.product.id == productId,
    );

    if (index == -1) return;

    final item = items[index];

    if (item.quantity > 1) {
      items[index] = CartItemView(
        id: item.id,
        product: item.product,
        quantity: item.quantity - 1,
      );
    } else {
      items.removeAt(index);
    }

    _cart = CartView(
      id: _cart!.id,
      createdAt: _cart!.createdAt,
      cartItems: items,
    );

    notifyListeners();
  }

  void clear() {
    _cart = null;
    notifyListeners();
  }
}
