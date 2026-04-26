import 'package:frontend/model/product_view.dart';

class CartItemView {
  final int id;
  final ProductView product;
  final int quantity;

  CartItemView({
    required this.id,
    required this.product,
    required this.quantity,
  });

  double get subtotal => quantity * product.price;

  factory CartItemView.fromJson(Map<String, dynamic> json) {
    return CartItemView(
      id: (json['id'] as num).toInt(),
      product: ProductView.fromJson(
        json['product'] as Map<String, dynamic>,
      ),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
