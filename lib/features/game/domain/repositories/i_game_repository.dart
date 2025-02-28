import '../../data/models/product.dart';

abstract class IGameRepository {
  Future<List<Product>> getProducts();
  Future<void> submitResults({required int bonus, required List<int> likeIds});
}
