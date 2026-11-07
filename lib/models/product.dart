class Product {
  final String id;
  final String name;
  final String description;
  final int price;
  final String category;
  final String? imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
  });
}
