import 'package:dayme_test_task/features/game/data/repositories/game_repository.dart';
import 'package:dayme_test_task/features/game/presentation/widgets/game_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/game/game_bloc.dart';
import '../bloc/game/game_event.dart';
import '../bloc/game/game_state.dart';
import '../widgets/game_header.dart';
import '../widgets/game_score_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/product_selection.dart';
import '../widgets/start_button.dart';

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
                if (state is GameLoaded && !state.isGameStarted)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        GameImageAssets.promoIcon.svg,
                        const Spacer(),
                        Text(
                          'завантаження ...',
                          style: AppTextStyles.mariupolBold20.copyWith(
                            color: AppColors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const StartButton(),
                        const Spacer(),
                      ],
                    ),
                  )
                else if (state is GameLoaded && state.isGameStarted)
                  Column(
                    children: [
                      const SizedBox(height: 56),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16.0),
                        child: Expanded(
                          child: GameProgressIndicator(
                            currentStep: state.currentStep,
                            totalSteps: 10,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'А що обереш ти?',
                        style: AppTextStyles.mariupolBold32,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ProductSelection(state: state),
                      const Spacer(),
                      if (state.selectedProduct != null) const NextButton(),
                      const Spacer(),
                    ],
                  ),
                if ((state is GameLoaded &&
                        state.isGameStarted &&
                        state.currentPair.length == 2) ||
                    state is GameFinished)
                  Positioned(
                    left: 16,
                    right: 16,
                    top: 16,
                    child: GameHeader(
                      state: state,
                      onClose: () => Navigator.of(context).pop(),
                    ),
                  ),
                if (state is GameLoading)
                  const Center(
                    child: CircularProgressIndicator(),
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
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GameImageAssets.defaultCoin.svg,
                              const SizedBox(width: 8),
                              Text(
                                'Забрати бонус',
                                style: AppTextStyles.mariupolBold20.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
