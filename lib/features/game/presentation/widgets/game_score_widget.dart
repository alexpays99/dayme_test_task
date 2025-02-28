import 'package:flutter/material.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/app_theme.dart';

class GameScoreWidget extends StatelessWidget {
  final int score;

  const GameScoreWidget({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GameImageAssets.activeCoin.svg,
          const SizedBox(width: 8),
          Text(
            score.toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.yellow,
                ),
          ),
        ],
      ),
    );
  }
}
