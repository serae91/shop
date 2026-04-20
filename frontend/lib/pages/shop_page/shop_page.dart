import 'package:flutter/material.dart';
import 'package:frontend/model/product_view.dart';
import 'package:frontend/pages/shop_page/shop_page_drawer/shop_page_drawer.dart';
import 'package:frontend/services/category_service.dart';
import 'package:frontend/services/product_service.dart';
import 'package:provider/provider.dart';

import '../../model/category_view.dart';
import '../../services/theme_service.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int selectedCategoryId = 0;
  String selectedLanguage = "DE";

  final ProductService _productService = ProductService();
  final CategoryService _categoryService = CategoryService();
  late Future<List<ProductView>> _productsFuture;
  late Future<List<CategoryView>> _categoriesFuture;

  final categories = ["All", "Shoes", "Clothes", "Accessories", "Furniture", "Toys"];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadCategoriess();
  }

  void _loadProducts() {
    _productsFuture = _productService.getProducts();
  }

  void _loadCategoriess() {
    _categoriesFuture = _categoryService.getCategories();
  }

  void _reload() {
    setState(() {
      _loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,

      // 🧠 APP BAR
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: const Text("Online Shop"),
        actions: [
          // 🌙 Theme toggle
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
                  child: Text("DE", style: TextStyle(color: colorScheme.onSurface)),
                ),
                DropdownMenuItem(
                  value: "EN",
                  child: Text("EN", style: TextStyle(color: colorScheme.onSurface)),
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

          IconButton(
            icon: Icon(Icons.refresh, color: colorScheme.onSurface),
            onPressed: _reload,
          ),

          const SizedBox(width: 8),

          IconButton(
            icon: Icon(Icons.person, color: colorScheme.onSurface),
            onPressed: () {},
          ),
        ],
      ),

      // 📂 DRAWER
      drawer: FutureBuilder<List<CategoryView>>(
    future: _categoriesFuture,
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Drawer(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final categories = snapshot.data!;


        return ShopPageDrawer(
          categories: categories,
          selectedCategoryId: selectedCategoryId,
          onSelect: (cat) {
            setState(() {
              selectedCategoryId = cat;
            });
            Navigator.pop(context);
          },
        );
      },
    ),

      // 🛍️ BODY
      body: FutureBuilder<List<ProductView>>(
        future: _productsFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Fehler beim Laden der Produkte",
                style: TextStyle(color: colorScheme.error),
              ),
            );
          }

          final products = snapshot.data ?? [];

          final filtered = selectedCategoryId == 0
              ? products
              : products
              .where((p) => p.category.id == selectedCategoryId)
              .toList();

          if (filtered.isEmpty) {
            return const Center(child: Text("Keine Produkte gefunden"));
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = filtered[index];

                return Card(
                  color: colorScheme.surface,
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // 🖼️ IMAGE
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            product.productImage.url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // NAME
                            Text(
                              product.name,
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            // CATEGORY
                            Text(
                              product.category.name,
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // PRICE
                            Text(
                              "€${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // BUTTON
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                ),
                                onPressed: () {
                                  // TODO: Add to cart
                                },
                                child: const Text("Add to Cart"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}