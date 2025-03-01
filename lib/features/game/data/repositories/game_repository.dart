import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../../core/services/http_service.dart';
import '../models/product.dart';
import '../../domain/repositories/i_game_repository.dart';

class GameRepository implements IGameRepository {
  GameRepository(this._httpService);

  final HttpService _httpService;
  static const String baseUrl = 'https://dayme.com.ua/game/';

  @override
  Future<List<Product>> getProducts() async {
    try {
      debugPrint('Fetching products from API');
      final response = await _httpService.get(baseUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Product> allProducts = [];

        // API returns array of arrays, each inner array contains 2 products
        for (var pair in data) {
          if (pair is List) {
            for (var productJson in pair) {
              if (productJson is Map<String, dynamic>) {
                allProducts.add(Product.fromJson(productJson));
              }
            }
          }
        }

        if (allProducts.isEmpty) {
          throw const FormatException('No valid products found in response');
        }

        return allProducts;
      } else {
        throw HttpException(
          'Server returned ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('Error in getProducts: $e');
      rethrow;
    }
  }

  @override
  Future<String> submitResults({
    required int bonus,
    required List<int> likeIds,
  }) async {
    try {
      final response = await _httpService.post(
        baseUrl,
        body: {
          'bonus': bonus,
          'likeIds': likeIds,
        },
      );

      if (!response.statusCode.toString().startsWith('2')) {
        throw HttpException(
          'Failed to submit results: ${response.statusCode} - ${response.body}',
        );
      }
      return jsonDecode(response.body)['message'];
    } catch (e) {
      debugPrint('Error in submitResults: $e');
      rethrow;
    }
  }
}
