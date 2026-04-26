import 'package:flutter/material.dart';

import '../../model/order_view.dart';

class OrderPage extends StatelessWidget {
  final List<OrderView> orders;

  const OrderPage({super.key, required this.orders});

  Color _statusColor(String status) {
    switch (status) {
      case 'PAID':
      case 'DELIVERED':
        return Colors.green;
      case 'PROCESSING':
      case 'SHIPPED':
      case 'OUT_FOR_DELIVERY':
        return Colors.blue;
      case 'PAYMENT_PENDING':
      case 'PENDING':
        return Colors.orange;
      case 'CANCELED':
      case 'PAYMENT_FAILED':
      case 'REFUNDED':
      case 'RETURNED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meine Bestellungen')),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('Bestellung #${order.id}'),
              subtitle: Text(order.createdAt.toIso8601String()),
              trailing: Text('€${order.totalPrice.toStringAsFixed(2)}'),
            ),
          );
        },
      ),
    );
  }
}
