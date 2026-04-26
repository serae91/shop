import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/cart_service.dart';

enum ShippingMethod { standard, express }

enum PaymentMethod { card, paypal }

// =========================
// CHECKOUT PAGE
// =========================

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  ShippingMethod _shipping = ShippingMethod.standard;
  PaymentMethod _payment = PaymentMethod.card;

  void _placeOrder() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Bestellung erfolgreich"),
        content: const Text("Deine Bestellung wurde erstellt."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartService = context.watch<CartService>();
    final items = cartService.items;
    subtotal() => items.fold(0.0, (sum, item) => sum + item.subtotal);
    shippingCost() => _shipping == ShippingMethod.express ? 9.99 : 3.99;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("Lieferadresse"),
          _buildAddressCard(),
          const SizedBox(height: 16),
          _buildSectionTitle("Versand"),
          _buildShippingCard(),
          const SizedBox(height: 16),
          _buildSectionTitle("Zahlung"),
          _buildPaymentCard(),
          const SizedBox(height: 16),
          _buildSectionTitle("Bestellübersicht"),
          _buildSummaryCard(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Card(
      child: ListTile(
        title: const Text("Max Mustermann"),
        subtitle: const Text("Musterstraße 1\n80331 München"),
        trailing: TextButton(
          onPressed: () {},
          child: const Text("Ändern"),
        ),
      ),
    );
  }

  Widget _buildShippingCard() {
    return Card(
      child: Column(
        children: [
          RadioListTile<ShippingMethod>(
            title: const Text("Standard (3–5 Tage)"),
            value: ShippingMethod.standard,
            groupValue: _shipping,
            onChanged: (v) => setState(() => _shipping = v!),
          ),
          RadioListTile<ShippingMethod>(
            title: const Text("Express (1–2 Tage)"),
            value: ShippingMethod.express,
            groupValue: _shipping,
            onChanged: (v) => setState(() => _shipping = v!),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Card(
      child: Column(
        children: [
          RadioListTile<PaymentMethod>(
            title: const Text("Kreditkarte"),
            value: PaymentMethod.card,
            groupValue: _payment,
            onChanged: (v) => setState(() => _payment = v!),
          ),
          RadioListTile<PaymentMethod>(
            title: const Text("PayPal"),
            value: PaymentMethod.paypal,
            groupValue: _payment,
            onChanged: (v) => setState(() => _payment = v!),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final cartService = context.watch<CartService>();
    final items = cartService.items;
    subtotal() => items.fold(0.0, (sum, item) => sum + item.subtotal);
    shippingCost() => _shipping == ShippingMethod.express ? 9.99 : 3.99;
    total() => subtotal() + shippingCost();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ...items.map(
              (item) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${item.product.name} x${item.quantity}"),
                  Text("€${item.subtotal.toStringAsFixed(2)}"),
                ],
              ),
            ),
            const Divider(height: 20),
            _row("Zwischensumme", subtotal()),
            _row("Versand", shippingCost()),
            const Divider(),
            _row("Gesamt", total(), bold: true),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "€${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final cartService = context.watch<CartService>();
    final items = cartService.items;
    subtotal() => items.fold(0.0, (sum, item) => sum + item.subtotal);
    shippingCost() => _shipping == ShippingMethod.express ? 9.99 : 3.99;
    total() => subtotal() + shippingCost();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: _placeOrder,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(14),
          ),
          child: Text("Jetzt bezahlen • €${total().toStringAsFixed(2)}"),
        ),
      ),
    );
  }
}
