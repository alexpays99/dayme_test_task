import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../../core/services/http_service.dart';
import '../models/cached_product.dart';
import '../models/product.dart';
import '../services/cache_service.dart';
import '../../domain/repositories/i_game_repository.dart';

class GameRepository implements IGameRepository {
  GameRepository({
    http.Client? client,
    CacheService? cacheService,
    HttpService? httpService,
  })  : _client = client ?? http.Client(),
        _cacheService = cacheService ?? CacheService(),
        _httpService = httpService ?? HttpService();

  final http.Client _client;
  final CacheService _cacheService;
  final HttpService _httpService;
  static const String baseUrl = 'https://dayme.com.ua/game/';

  @override
  Future<List<Product>> getProducts() async {
    try {
      // Check cache first
      if (_cacheService.isCacheValid()) {
        final cachedProducts = await _cacheService.getCachedProducts();
        if (cachedProducts.isNotEmpty) {
          return cachedProducts
              .map((cached) => Product(
                    productId: cached.productId,
                    name: cached.name,
                    photoUrl: cached.photoUrl,
                  ))
              .toList();
        }
      }

      // If cache is invalid or empty, fetch from API
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

        // Cache the new data
        final cachedProducts = allProducts
            .map((product) => CachedProduct(
                  productId: product.productId,
                  name: product.name,
                  photoUrl: product.photoUrl,
                  cachedAt: DateTime.now(),
                ))
            .toList();
        await _cacheService.cacheProducts(cachedProducts);

        return allProducts;
      } else {
        throw HttpException(
          'Server returned ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      // If API call fails, try to return cached data even if expired
      final cachedProducts = await _cacheService.getCachedProducts();
      if (cachedProducts.isNotEmpty) {
        return cachedProducts
            .map((cached) => Product(
                  productId: cached.productId,
                  name: cached.name,
                  photoUrl: cached.photoUrl,
                ))
            .toList();
      }
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
