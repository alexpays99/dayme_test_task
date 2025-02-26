import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/game_service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameService _gameService = GameService();
  List<List<Product>> _products = [];
  List<int> _likedProducts = [];
  int _currentStep = 0;
  int _bonus = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _gameService.getProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      // Обработка ошибки
    }
  }

  void _selectProduct(Product product) {
    setState(() {
      _likedProducts.add(product.productId);
      _bonus += 2;
      _currentStep++;
    });

    if (_currentStep >= 10) {
      _submitGame();
    }
  }

  Future<void> _submitGame() async {
    try {
      await _gameService.submitResults(
        bonus: _bonus,
        likeIds: _likedProducts,
      );
      // Показать экран завершения
    } catch (e) {
      // Обработка ошибки
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: _currentStep / 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),

            // Counter
            Text('${_currentStep + 1} / 10'),

            // Products
            if (_currentStep < 10) ...[
              Row(
                children: _products[_currentStep].map((product) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _selectProduct(product),
                      child: Card(
                        child: Column(
                          children: [
                            Image.network(product.photoUrl),
                            Text(product.name),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
