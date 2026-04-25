import 'package:frontend/model/category_view.dart';
import 'package:frontend/model/product_image_view.dart';

class ProductView {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final CategoryView category;
  final DateTime createdAt;
  final ProductImageView productImage;

  ProductView({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.createdAt,
    required this.productImage,
  });

  factory ProductView.fromJson(Map<String, dynamic> json) {
    return ProductView(
      id: (json['id'] as num).toInt(),
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      category: CategoryView.fromJson(json['category']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      productImage: ProductImageView.fromJson(json['productImage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'category': category.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'productImage': productImage.toJson(),
    };
  }
}
