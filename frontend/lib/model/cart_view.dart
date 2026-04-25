import 'package:frontend/model/cart_item_view.dart';

class CartView {
  final int id;
  final DateTime createdAt;
  final List<CartItemView> cartItems;

  CartView({
    required this.id,
    required this.createdAt,
    required this.cartItems,
  });

  factory CartView.fromJson(Map<String, dynamic> json) {
    return CartView(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      cartItems: (json['cartItems'] as List)
          .map((item) => CartItemView.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'cartItems': cartItems.map((e) => e.toJson()).toList(),
    };
  }
}
