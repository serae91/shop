import 'package:flutter/material.dart';

import '../../model/order_item_view.dart';
import '../../model/order_view.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderView order;
  final List<OrderItemView> items;

  const OrderDetailPage({
    super.key,
    required this.order,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bestellung #${order.id}'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bestelldetails',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text('Status: ${order.status}'),
                  Text('Erstellt: ${order.createdAt}'),
                  const Divider(height: 24),
                  Text(
                    'Gesamtsumme: €${order.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(item.quantity.toString()),
                  ),
                  title: Text(item.productName),
                  subtitle: Text(
                    '€${item.priceAtTime.toStringAsFixed(2)} pro Stück',
                  ),
                  trailing: Text(
                    '€${item.subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
