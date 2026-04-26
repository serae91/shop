import 'package:flutter/material.dart';
import 'package:frontend/features/shop_page/shop_page_app_bar/shop_page_app_bar.dart';
import 'package:frontend/features/shop_page/shop_page_product/shop_page_product.dart';
import 'package:frontend/features/shop_page/shop_page_sidebar/shop_page_sidebar.dart';
import 'package:frontend/model/product_view.dart';
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
  String selectedLanguage = 'DE';

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

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: color.background,
      appBar: const ShopPageAppBar(),
      body: Row(
        children: [
          SizedBox(
            width: 280,
            child: FutureBuilder<List<CategoryView>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Material(
                  color: color.surface,
                  elevation: 1,
                  child: ShopPageSidebar(
                    categories: snapshot.data!,
                    selectedCategoryId: selectedCategoryId,
                    onSelect: (id) {
                      setState(() => selectedCategoryId = id);
                    },
                  ),
                );
              },
            ),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: color.outlineVariant,
          ),
          Expanded(
            child: FutureBuilder<List<ProductView>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Fehler beim Laden'),
                  );
                }

                final products = snapshot.data ?? [];

                final filtered = selectedCategoryId == 0
                    ? products
                    : products
                        .where(
                          (p) => p.category.id == selectedCategoryId,
                        )
                        .toList();

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: filtered.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.72,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return ShopPageProduct(
                        product: filtered[index],
                      );
                    },
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
