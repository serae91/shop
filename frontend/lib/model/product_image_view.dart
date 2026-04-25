class ProductImageView {
  final int id;
  final String url;

  ProductImageView({
    required this.id,
    required this.url,
  });

  factory ProductImageView.fromJson(Map<String, dynamic> json) {
    return ProductImageView(
      id: (json['id'] as num).toInt(),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}
