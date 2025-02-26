import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class GameService {
  static const String baseUrl = 'https://dayme.com.ua/game/';

  Future<List<List<Product>>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((pair) => (pair as List)
                .map((product) =>
                    Product.fromJson(product as Map<String, dynamic>))
                .toList())
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> submitResults({
    required int bonus,
    required List<int> likeIds,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'bonus': bonus,
          'likeIds': likeIds,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to submit results');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
