import 'package:flutter/material.dart';
import 'package:frontend/model/category_view.dart';

class ShopPageSidebar extends StatelessWidget {
  final List<CategoryView> categories;
  final int selectedCategoryId;
  final Function(int) onSelect;

  const ShopPageSidebar({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final list = [
      CategoryView(id: 0, name: "All"),
      ...categories,
    ];

    return Container(
      width: 260,
      color: color.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final c = list[i];
                  final selected = c.id == selectedCategoryId;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor:
                          selected ? color.primary.withOpacity(0.1) : null,
                      leading: Icon(
                        Icons.category,
                        color:
                            selected ? color.primary : color.onSurfaceVariant,
                      ),
                      title: Text(c.name),
                      onTap: () => onSelect(c.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
