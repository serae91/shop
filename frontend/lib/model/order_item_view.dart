class OrderItemView {
  final int id;
  final String productName;
  final int quantity;
  final double priceAtTime;

  OrderItemView({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.priceAtTime,
  });

  double get subtotal => quantity * priceAtTime;

  factory OrderItemView.fromJson(Map<String, dynamic> json) {
    return OrderItemView(
      id: (json['id'] as num).toInt(),
      productName: json['productName'],
      quantity: json['quantity'] as int,
      priceAtTime: (json['priceAtTime'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'quantity': quantity,
      'priceAtTime': priceAtTime,
    };
  }
}
