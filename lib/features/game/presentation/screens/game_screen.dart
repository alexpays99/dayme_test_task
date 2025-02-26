import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/assets.dart';
import '../bloc/game/game_bloc.dart';
import '../bloc/game/game_event.dart';
import '../bloc/game/game_state.dart';
import '../widgets/game_progress_indicator.dart';
import '../widgets/product_card.dart';
import '../widgets/game_score_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GameScreenView();
  }
}

class GameScreenView extends StatelessWidget {
  const GameScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: GameImageAssets.close.svg,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is GameLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GameError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is GameLoaded) {
              return Column(
                children: [
                  GameProgressIndicator(
                    currentStep: state.currentStep,
                    totalSteps: 10,
                  ),
                  GameScoreWidget(score: state.bonus),
                  if (state.currentStep < 10) ...[
                    Row(
                      children:
                          state.products[state.currentStep].map((product) {
                        return Expanded(
                          child: ProductCard(
                            product: product,
                            isSelected:
                                state.likedProducts.contains(product.productId),
                            onTap: () => context.read<GameBloc>().add(
                                  SelectProduct(product),
                                ),
                          ),
                        );
                      }).toList(),
                    ),
                  ] else ...[
                    Center(
                      child: Column(
                        children: [
                          GameImageAssets.winIcon.svg,
                          const Text('Игра завершена!'),
                          GameScoreWidget(score: state.bonus),
                        ],
                      ),
                    ),
                  ],
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
