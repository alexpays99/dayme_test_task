import 'dart:convert';
import '../../../../core/services/http_service.dart';
import '../models/product.dart';
import '../../domain/repositories/i_game_repository.dart';

class GameRepository implements IGameRepository {
  final HttpService _httpService;
  static const String baseUrl = 'https://dayme.com.ua/game/';

  GameRepository({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<List<List<Product>>> getProducts() async {
    try {
      final response = await _httpService.get(baseUrl);
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((pair) => (pair as List)
              .map((product) =>
                  Product.fromJson(product as Map<String, dynamic>))
              .toList())
          .toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Future<void> submitResults({
    required int bonus,
    required List<int> likeIds,
  }) async {
    try {
      final response = await _httpService.post(
        baseUrl,
        body: {'bonus': bonus, 'likeIds': likeIds},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to submit results');
      }
    } catch (e) {
      throw Exception('Error submitting results: $e');
    }
  }
}
