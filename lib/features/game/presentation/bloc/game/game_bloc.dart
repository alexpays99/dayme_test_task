import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/i_game_repository.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final IGameRepository _repository;

  GameBloc(this._repository) : super(GameInitial()) {
    on<LoadGame>(_onLoadGame);
    on<SelectProduct>(_onSelectProduct);
  }

  Future<void> _onLoadGame(LoadGame event, Emitter<GameState> emit) async {
    emit(GameLoading());
    try {
      final products = await _repository.getProducts();
      emit(GameLoaded(
        products: products,
        likedProducts: [],
        currentStep: 0,
        bonus: 0,
      ));
    } catch (e) {
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

      emit(currentState.copyWith(
        likedProducts: newLikedProducts,
        bonus: newBonus,
        currentStep: newStep,
      ));

      if (newStep >= 10) {
        await _repository.submitResults(
          bonus: newBonus,
          likeIds: newLikedProducts,
        );
      }
    }
  }
}
