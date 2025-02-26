import 'package:equatable/equatable.dart';
import '../../../data/models/product.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameLoaded extends GameState {
  final List<List<Product>> products;
  final List<int> likedProducts;
  final int currentStep;
  final int bonus;

  const GameLoaded({
    required this.products,
    required this.likedProducts,
    required this.currentStep,
    required this.bonus,
  });

  @override
  List<Object> get props => [products, likedProducts, currentStep, bonus];

  GameLoaded copyWith({
    List<List<Product>>? products,
    List<int>? likedProducts,
    int? currentStep,
    int? bonus,
  }) {
    return GameLoaded(
      products: products ?? this.products,
      likedProducts: likedProducts ?? this.likedProducts,
      currentStep: currentStep ?? this.currentStep,
      bonus: bonus ?? this.bonus,
    );
  }
}

class GameError extends GameState {
  final String message;

  const GameError(this.message);

  @override
  List<Object> get props => [message];
}
