import 'package:flutter/material.dart';
import 'package:frontend/model/product_view.dart';
import 'package:frontend/pages/shop_page/shop_page_app_bar/shop_page_app_bar.dart';
import 'package:frontend/pages/shop_page/shop_page_drawer/shop_page_drawer.dart';
import 'package:frontend/pages/shop_page/shop_page_product/shop_page_product.dart';
import 'package:frontend/services/category_service.dart';
import 'package:frontend/services/product_service.dart';

import '../../model/category_view.dart';

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

  @override
  void initState() {
    super.initState();
    _productsFuture = _productService.getProducts();
    _categoriesFuture = _categoryService.getCategories();
  }

  void _reload() {
    setState(() {
      _productsFuture = _productService.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: color.background,

      // 🌟 APP BAR (clean + modern)
      appBar: ShopPageAppBar(),

      drawer: FutureBuilder<List<CategoryView>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Drawer(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return ShopPageDrawer(
            categories: snapshot.data!,
            selectedCategoryId: selectedCategoryId,
            onSelect: (id) {
              setState(() => selectedCategoryId = id);
              Navigator.pop(context);
            },
          );
        },
      ),

      // 🛍️ BODY
      body: FutureBuilder<List<ProductView>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Fehler beim Laden"));
          }

          final products = snapshot.data ?? [];

          final filtered = selectedCategoryId == 0
              ? products
              : products
                  .where((p) => p.category.id == selectedCategoryId)
                  .toList();

          return Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.72,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, i) {
                final p = filtered[i];

                return ShopPageProduct(product: p);
              },
            ),
          );
        },
      ),
    );
  }
}
