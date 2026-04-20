import 'package:flutter/material.dart';
import 'package:frontend/model/product_view.dart';
import 'package:frontend/pages/shop_page/shop_page_drawer/shop_page_drawer.dart';
import 'package:frontend/services/category_service.dart';
import 'package:frontend/services/product_service.dart';
import 'package:provider/provider.dart';

import '../../model/category_view.dart';
import '../../services/auth_service.dart';
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
      appBar: AppBar(
        backgroundColor: color.surface,
        elevation: 0,
        title: const Text(
          "Shop",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reload,
          ),
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => context.read<ThemeService>().toggle(),
          ),
          const SizedBox(width: 8),
        ],
      ),

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
              : products.where((p) => p.category.id == selectedCategoryId).toList();

          return Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, i) {
                final p = filtered[i];

                return Container(
                  decoration: BoxDecoration(
                    color: color.surface,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // 🖼 IMAGE (modern rounded)
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                          child: Image.network(
                            p.productImage.url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // 📦 INFO
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              p.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              p.category.name,
                              style: TextStyle(
                                fontSize: 12,
                                color: color.onSurfaceVariant,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text(
                                  "€${p.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: color.primary,
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    color: color.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.add, size: 18),
                                    color: color.onPrimary,
                                    onPressed: () {
                                      final auth = context.read<AuthService>();

                                      if (!auth.isLoggedIn) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text("Login erforderlich"),
                                            content: const Text(
                                              "Du musst dich einloggen, um Produkte in den Warenkorb zu legen.",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text("Abbrechen"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pushNamed(context, "/login");
                                                },
                                                child: const Text("Login"),
                                              ),
                                            ],
                                          ),
                                        );
                                        return;
                                      }

                                      // 🛒 echte Cart Logik kommt hier später
                                      print("Produkt hinzugefügt: ${p.name}");
                                    },
                                  ),
                                ),
                              ],
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