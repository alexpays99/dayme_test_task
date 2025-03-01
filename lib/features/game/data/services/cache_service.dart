import 'package:hive_flutter/hive_flutter.dart';
import '../models/cached_product.dart';

class CacheService {
  static const String _productsBoxName = 'products';
  static const Duration _cacheValidDuration = Duration(hours: 24);

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CachedProductAdapter());
    await Hive.openBox<CachedProduct>(_productsBoxName);
  }

  Future<List<CachedProduct>> getCachedProducts() async {
    final box = Hive.box<CachedProduct>(_productsBoxName);
    return box.values.where((product) {
      final age = DateTime.now().difference(product.cachedAt);
      return age <= _cacheValidDuration;
    }).toList();
  }

  Future<void> cacheProducts(List<CachedProduct> products) async {
    final box = Hive.box<CachedProduct>(_productsBoxName);
    await box.clear(); // Clear old cache
    
    for (var product in products) {
      await box.put(product.productId.toString(), product);
    }
  }

  Future<void> clearCache() async {
    final box = Hive.box<CachedProduct>(_productsBoxName);
    await box.clear();
  }

  bool isCacheValid() {
    final box = Hive.box<CachedProduct>(_productsBoxName);
    if (box.isEmpty) return false;

    final latestProduct = box.values.first;
    final age = DateTime.now().difference(latestProduct.cachedAt);
    return age <= _cacheValidDuration;
  }
}
