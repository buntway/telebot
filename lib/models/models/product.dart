class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String availableCount;
  final List<String> photoUrl;
  final List<String> availableColors;
  final List<String> availableMaterials;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.availableCount,
    required this.photoUrl,
    required this.availableColors,
    required this.availableMaterials,
  });
}
