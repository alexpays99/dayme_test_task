import 'package:hive/hive.dart';

part 'cached_product.g.dart';

@HiveType(typeId: 0)
class CachedProduct extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String photoUrl;

  @HiveField(3)
  final DateTime cachedAt;

  CachedProduct({
    required this.productId,
    required this.name,
    required this.photoUrl,
    required this.cachedAt,
  });

  factory CachedProduct.fromJson(Map<String, dynamic> json) {
    return CachedProduct(
      productId: json['id'] as int,
      name: json['name'] as String,
      photoUrl: json['photo_url'] as String,
      cachedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'name': name,
      'photo_url': photoUrl,
    };
  }
}
