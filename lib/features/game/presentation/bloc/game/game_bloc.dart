import 'dart:math';

import 'package:dayme_test_task/features/game/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../domain/repositories/i_game_repository.dart';
import 'game_event.dart';
import 'game_state.dart';
import 'package:flutter/foundation.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(this._repository) : super(GameInitial()) {
    on<LoadGame>(_onLoadGame);
    on<StartGame>(_onStartGame);
    on<SelectProduct>(_onSelectProduct);
    on<NextStep>(_onNextStep);
    on<ClaimBonus>(_onClaimBonus);
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
        currentPair: const [],
        isGameStarted: false,
      ));
    } catch (e) {
      debugPrint('Error in LoadGame event: $e');
      emit(GameError(e.toString()));
    }
  }

  Future<void> _onStartGame(StartGame event, Emitter<GameState> emit) async {
    if (state is GameLoaded) {
      final currentState = state as GameLoaded;
      if (currentState.allProducts.isEmpty) {
        emit(GameError('No products available'));
        return;
      }

      final pair = _selectRandomPair(currentState.allProducts);
      if (pair.length != 2) {
        emit(GameError('Failed to generate product pair'));
        return;
      }

      emit(GameLoaded(
        allProducts: currentState.allProducts,
        currentPair: pair,
        isGameStarted: true,
        currentStep: 0,
        bonus: 0,
        likedProducts: const [],
        selectedProduct: null,
      ));
    }
  }

  Future<void> _onSelectProduct(
    SelectProduct event,
    Emitter<GameState> emit,
  ) async {
    if (state is GameLoaded) {
      final currentState = state as GameLoaded;
      if (!currentState.isGameStarted) return;

      emit(currentState.copyWith(
        selectedProduct: event.product,
      ));
    }
  }

  Future<void> _onNextStep(
    NextStep event,
    Emitter<GameState> emit,
  ) async {
    if (state is GameLoaded) {
      final currentState = state as GameLoaded;
      if (currentState.selectedProduct == null) return;

      final newLikedProducts = List<int>.from(currentState.likedProducts)
        ..add(currentState.selectedProduct!.productId);
      final newBonus = currentState.bonus + 2;
      final newStep = currentState.currentStep + 1;

      if (newStep < 10) {
        emit(currentState.copyWith(
          currentPair: _selectRandomPair(currentState.allProducts),
          likedProducts: newLikedProducts,
          bonus: newBonus,
          currentStep: newStep,
          selectedProduct: null,
        ));
      } else {
        emit(GameFinished(newBonus, newLikedProducts));
      }
    }
  }

  Future<void> _onClaimBonus(
    ClaimBonus event,
    Emitter<GameState> emit,
  ) async {
    if (state is GameFinished) {
      final currentState = state as GameFinished;
      try {
        await _repository.submitResults(
          bonus: currentState.bonus,
          likeIds: currentState.likedProducts,
        );
        emit(GameCompleted(currentState.bonus, currentState.likedProducts));
        Fluttertoast.showToast(
          msg: "Bonus successfully claimed!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (e) {
        emit(GameError(e.toString()));
      }
    }
  }

  Future<void> _onRestartGame(
    RestartGame event,
    Emitter<GameState> emit,
  ) async {
    emit(GameLoading());
    final products = await _repository.getProducts();
    emit(GameLoaded(
      allProducts: products,
      currentPair: _selectRandomPair(products),
      isGameStarted: false,
    ));
  }

  List<Product> _selectRandomPair(List<Product> products) {
    if (products.length < 2) return const [];
    final random = Random();
    final shuffled = List<Product>.from(products)..shuffle(random);
    return shuffled.take(2).toList();
  }
}
