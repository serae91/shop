import 'package:flutter/material.dart';

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
    final filtered = selectedCategory == "All"
        ? products
        : products.where((p) => p["category"] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Online Shop"),
        actions: [
          // 🌍 Language Dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedLanguage,
              items: const [
                DropdownMenuItem(value: "DE", child: Text("DE")),
                DropdownMenuItem(value: "EN", child: Text("EN")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
          ),

          const SizedBox(width: 10),

          // 👤 Profile
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text("Profil"),
                  content: Text("User Settings / Profile Page"),
                ),
              );
            },
          ),
        ],
      ),

      // 📂 Sidebar Kategorien
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Text(
                "Kategorien",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ...categories.map((cat) {
              return ListTile(
                title: Text(cat),
                selected: selectedCategory == cat,
                onTap: () {
                  setState(() {
                    selectedCategory = cat;
                  });
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),

      // 🛍️ Products
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: filtered.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final product = filtered[index];

            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag, size: 50),
                  const SizedBox(height: 10),
                  Text(product["name"].toString()),
                  Text("€${product["price"]}"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Add"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}