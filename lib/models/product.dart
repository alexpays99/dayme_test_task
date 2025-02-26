class Product {
  final String name;
  final String photoUrl;
  final int productId;

  Product({
    required this.name,
    required this.photoUrl,
    required this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      productId: json['productId'] as int,
    );
  }
}
