import 'package:flutter/material.dart';

class ShopPageDrawer extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onSelect;

  const ShopPageDrawer({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      child: Container(
        color: colorScheme.surface,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🧠 Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Shop",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),

              Divider(color: colorScheme.outlineVariant),

              // 📂 Kategorien
              Expanded(
                child: ListView(
                  children: categories.map((cat) {
                    final isSelected = cat == selectedCategory;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colorScheme.primary.withOpacity(0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.category,
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                          ),
                          title: Text(
                            cat,
                            style: TextStyle(
                              color: isSelected
                                  ? colorScheme.primary
                                  : colorScheme.onSurface,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          onTap: () => onSelect(cat),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              Divider(color: colorScheme.outlineVariant),

              // ⚙️ Footer
              ListTile(
                leading: Icon(Icons.settings,
                    color: colorScheme.onSurfaceVariant),
                title: Text(
                  "Settings",
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}