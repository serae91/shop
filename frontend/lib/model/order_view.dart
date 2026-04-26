class OrderView {
  final int id;
  final OrderStatus status;
  final double totalPrice;
  final DateTime createdAt;

  OrderView({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
  });

  factory OrderView.fromJson(Map<String, dynamic> json) {
    return OrderView(
      id: (json['id'] as num).toInt(),
      status: parseOrderStatus(json['status'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'totalPrice': totalPrice,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

enum OrderStatus {
  pending,
  paymentPending,
  paid,
  paymentFailed,
  processing,
  shipped,
  outForDelivery,
  delivered,
  canceled,
  returned,
  refunded,
  unknown,
}

OrderStatus parseOrderStatus(String value) {
  switch (value) {
    case 'PENDING':
      return OrderStatus.pending;
    case 'PAYMENT_PENDING':
      return OrderStatus.paymentPending;
    case 'PAID':
      return OrderStatus.paid;
    case 'PAYMENT_FAILED':
      return OrderStatus.paymentFailed;
    case 'PROCESSING':
      return OrderStatus.processing;
    case 'SHIPPED':
      return OrderStatus.shipped;
    case 'OUT_FOR_DELIVERY':
      return OrderStatus.outForDelivery;
    case 'DELIVERED':
      return OrderStatus.delivered;
    case 'CANCELED':
      return OrderStatus.canceled;
    case 'RETURNED':
      return OrderStatus.returned;
    case 'REFUNDED':
      return OrderStatus.refunded;
    default:
      return OrderStatus.unknown;
  }
}
