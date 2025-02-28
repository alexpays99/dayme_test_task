import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/app_theme.dart';
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
      body: SafeArea(
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return Stack(
              children: [
                // Close button
                Positioned(
                  left: 16,
                  top: 16,
                  child: IconButton(
                    icon: GameImageAssets.close.svg,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                if (state is GameLoading)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GameImageAssets.promoIcon.svg,
                        const SizedBox(height: 24),
                        const Text(
                          'Завантаження...',
                          style: AppTextStyles.mariupolBold20,
                        ),
                      ],
                    ),
                  )
                else if (state is GameError)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Помилка: ${state.message}',
                          style: AppTextStyles.mariupolBold20,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<GameBloc>().add(LoadGame()),
                          child: const Text('Спробувати знову'),
                        ),
                      ],
                    ),
                  )
                else if (state is GameLoaded)
                  Column(
                    children: [
                      const SizedBox(height: 56),
                      GameProgressIndicator(
                        currentStep: state.currentStep,
                        totalSteps: 10,
                      ),
                      const SizedBox(height: 8),
                      GameScoreWidget(score: state.bonus),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: state.currentPair.map((product) {
                              return Expanded(
                                child: ProductCard(
                                  product: product,
                                  isSelected: state.likedProducts
                                      .contains(product.productId),
                                  onTap: () => context
                                      .read<GameBloc>()
                                      .add(SelectProduct(product)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  )
                else if (state is GameCompleted)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GameImageAssets.winIcon.svg,
                        const SizedBox(height: 24),
                        const Text(
                          'Вітаємо!',
                          style: AppTextStyles.mariupolBold32,
                        ),
                        const Text(
                          'Твій виграш',
                          style: AppTextStyles.mariupolBold20,
                        ),
                        const SizedBox(height: 16),
                        GameScoreWidget(score: state.finalScore),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<GameBloc>().add(RestartGame()),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GameImageAssets.defaultCoin.svg,
                              const SizedBox(width: 8),
                              const Text('Забрати бонуси'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
