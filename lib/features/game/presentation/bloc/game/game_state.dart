import 'package:equatable/equatable.dart';
import '../../../data/models/product.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameLoaded extends GameState {
  final List<Product> allProducts;
  final List<Product> currentPair;
  final int currentStep;
  final int bonus;
  final List<int> likedProducts;
  final Product? selectedProduct;
  final bool isGameStarted;

  const GameLoaded({
    required this.allProducts,
    required this.currentPair,
    this.currentStep = 0,
    this.bonus = 0,
    this.likedProducts = const [],
    this.selectedProduct,
    this.isGameStarted = false,
  });

  GameLoaded copyWith({
    List<Product>? allProducts,
    List<Product>? currentPair,
    int? currentStep,
    int? bonus,
    List<int>? likedProducts,
    Product? selectedProduct,
    bool? isGameStarted,
  }) {
    return GameLoaded(
      allProducts: allProducts ?? this.allProducts,
      currentPair: currentPair ?? this.currentPair,
      currentStep: currentStep ?? this.currentStep,
      bonus: bonus ?? this.bonus,
      likedProducts: likedProducts ?? this.likedProducts,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      isGameStarted: isGameStarted ?? this.isGameStarted,
    );
  }

  @override
  List<Object> get props => [
        allProducts,
        currentPair,
        currentStep,
        bonus,
        likedProducts,
        selectedProduct ?? '',
        isGameStarted,
      ];
}

class GameFinished extends GameState {
  final int bonus;
  final List<int> likedProducts;

  const GameFinished(this.bonus, this.likedProducts);

  @override
  List<Object> get props => [bonus, likedProducts];
}

class GameCompleted extends GameState {
  final int finalScore;
  final List<int> likedProducts;

  const GameCompleted(this.finalScore, this.likedProducts);

  @override
  List<Object> get props => [finalScore, likedProducts];
}

class GameError extends GameState {
  final String message;

  const GameError(this.message);

  @override
  List<Object> get props => [message];
}
