import 'dart:math';

import 'package:dayme_test_task/features/game/data/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/i_game_repository.dart';
import 'game_event.dart';
import 'game_state.dart';
import 'package:flutter/foundation.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(this._repository) : super(GameInitial()) {
    on<LoadGame>(_onLoadGame);
    on<SelectProduct>(_onSelectProduct);
    on<RestartGame>(_onRestartGame);
  }

  final IGameRepository _repository;

  Future<void> _onLoadGame(LoadGame event, Emitter<GameState> emit) async {
    try {
      emit(GameLoading());
      final products = await _repository.getProducts();
      if (products.isEmpty) {
        emit(const GameError('No products found'));
        return;
      }
      emit(GameLoaded(
        allProducts: products,
        currentPair: _selectRandomPair(products),
      ));
    } catch (e) {
      debugPrint('Error in LoadGame event: $e');
      emit(GameError(e.toString()));
    }
  }

  Future<void> _onSelectProduct(
      SelectProduct event, Emitter<GameState> emit) async {
    if (state is GameLoaded) {
      final currentState = state as GameLoaded;
      final newLikedProducts = List<int>.from(currentState.likedProducts)
        ..add(event.product.productId);
      final newBonus = currentState.bonus + 2;
      final newStep = currentState.currentStep + 1;

      if (newStep < 10) {
        emit(currentState.copyWith(
          currentPair: _selectRandomPair(currentState.allProducts),
          likedProducts: newLikedProducts,
          bonus: newBonus,
          currentStep: newStep,
        ));
      } else {
        await _repository.submitResults(
          bonus: newBonus,
          likeIds: newLikedProducts,
        );
        emit(GameCompleted(newBonus, newLikedProducts));
      }
    }
  }

  Future<void> _onRestartGame(
      RestartGame event, Emitter<GameState> emit) async {
    emit(GameLoading());
    final products = await _repository.getProducts();
    emit(GameLoaded(
      allProducts: products,
      currentPair: _selectRandomPair(products),
    ));
  }

  List<Product> _selectRandomPair(List<Product> products) {
    final random = Random();
    final shuffled = List<Product>.from(products)..shuffle(random);
    return shuffled.take(2).toList();
  }
}
