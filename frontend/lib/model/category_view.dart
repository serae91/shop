class CategoryView {
  final int id;
  final String name;

  CategoryView({
    required this.id,
    required this.name,
  });

  factory CategoryView.fromJson(Map<String, dynamic> json) {
    return CategoryView(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}