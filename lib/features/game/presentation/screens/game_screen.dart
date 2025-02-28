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
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else if (state is GameLoaded && !state.isGameStarted)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GameImageAssets.promoIcon.svg,
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<GameBloc>().add(StartGame()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'Старт',
                            style: AppTextStyles.mariupolBold20,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (state is GameLoaded &&
                    state.isGameStarted &&
                    state.currentPair.length == 2)
                  Column(
                    children: [
                      const SizedBox(height: 56),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GameProgressIndicator(
                                currentStep: state.currentStep,
                                totalSteps: 10,
                              ),
                            ),
                            GameScoreWidget(score: state.bonus),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'А що обереш ти?',
                        style: AppTextStyles.mariupolBold20,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: ProductCard(
                                  product: state.currentPair[0],
                                  isSelected: state.likedProducts
                                      .contains(state.currentPair[0].productId),
                                  onTap: () => context
                                      .read<GameBloc>()
                                      .add(SelectProduct(state.currentPair[0])),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.purple,
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  'або',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: ProductCard(
                                  product: state.currentPair[1],
                                  isSelected: state.likedProducts
                                      .contains(state.currentPair[1].productId),
                                  onTap: () => context
                                      .read<GameBloc>()
                                      .add(SelectProduct(state.currentPair[1])),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (state.selectedProduct != null)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () =>
                                context.read<GameBloc>().add(NextStep()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.purple,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(16),
                            ),
                            child: const Text(
                              'Далі',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
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
                else if (state is GameFinished)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Вітаємо!\nТвій виграш',
                          style: AppTextStyles.mariupolBold32,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        GameImageAssets.winIcon.svg,
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<GameBloc>().add(ClaimBonus()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.yellow,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'Забрати бонус',
                            style: AppTextStyles.mariupolBold20,
                          ),
                        ),
                      ],
                    ),
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
