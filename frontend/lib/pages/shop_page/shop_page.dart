import 'package:flutter/material.dart';
import 'package:frontend/pages/shop_page/shop_page_drawer/shop_page_drawer.dart';
import 'package:provider/provider.dart';

import '../../services/theme_service.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String selectedCategory = "All";
  String selectedLanguage = "DE";

  final categories = ["All", "Shoes", "Clothes", "Accessories"];

  final products = const [
    {"name": "Sneaker", "category": "Shoes", "price": 79.99},
    {"name": "T-Shirt", "category": "Clothes", "price": 19.99},
    {"name": "Hoodie", "category": "Clothes", "price": 49.99},
    {"name": "Cap", "category": "Accessories", "price": 14.99},
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final filtered = selectedCategory == "All"
        ? products
        : products.where((p) => p["category"] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: colorScheme.background,

      // 🧠 AppBar
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: const Text("Online Shop"),
        actions: [
          // Theme
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeService>().toggle();
            },
          ),

          const SizedBox(width: 8),

          // 🌍 Language
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedLanguage,
              dropdownColor: colorScheme.surface,
              items: [
                DropdownMenuItem(
                  value: "DE",
                  child: Text(
                    "DE",
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ),
                DropdownMenuItem(
                  value: "EN",
                  child: Text(
                    "EN",
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
          ),

          const SizedBox(width: 8),

          // 👤 Profile
          IconButton(
            icon: Icon(Icons.person, color: colorScheme.onSurface),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: colorScheme.surface,
                  title: Text(
                    "Profil",
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                  content: Text(
                    "User Settings / Profile Page",
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // 📂 Drawer
      drawer: ShopPageDrawer(
        categories: categories,
        selectedCategory: selectedCategory,
        onSelect: (cat) {
          setState(() {
            selectedCategory = cat;
          });
          Navigator.pop(context);
        },
      ),

      // 🛍️ BODY
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: filtered.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.78,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final product = filtered[index];

            return Card(
              color: colorScheme.surface,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      size: 50,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 10),

                    Text(
                      product["name"].toString(),
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "€${product["price"]}",
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                      onPressed: () {},
                      child: const Text("Add"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}