import 'package:equatable/equatable.dart';
import '../../../data/models/product.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class LoadGame extends GameEvent {}

class SelectProduct extends GameEvent {
  final Product product;

  const SelectProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RestartGame extends GameEvent {}
