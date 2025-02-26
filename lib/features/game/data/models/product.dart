import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String photoUrl;
  final int productId;

  const Product({
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

  @override
  List<Object> get props => [name, photoUrl, productId];
}
