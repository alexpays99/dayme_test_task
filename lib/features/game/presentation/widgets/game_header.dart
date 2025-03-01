import 'package:dayme_test_task/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/assets.dart';
import '../widgets/game_score_widget.dart';
import '../bloc/game/game_state.dart';

class GameHeader extends StatelessWidget {
  final GameState state;
  final VoidCallback onClose;

  const GameHeader({
    super.key,
    required this.state,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    late final int currentStep;
    late final int score;

    if (state is GameLoaded) {
      final gameState = state as GameLoaded;
      currentStep = gameState.currentStep + 1;
      score = gameState.bonus;
    } else {
      final gameState = state as GameFinished;
      currentStep = gameState.currentStep;
      score = gameState.bonus;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(icon: GameImageAssets.close.svg, onPressed: onClose),
        const Spacer(),
        Text(' 10 / $currentStep', style: AppTextStyles.mariupolBold20),
        const SizedBox(width: 8),
        GameScoreWidget(score: score),
      ],
    );
  }
}
