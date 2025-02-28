import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class GameProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const GameProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'А що обереш ти?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '${currentStep + 1} / $totalSteps',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isCompleted || isCurrent
                        ? AppColors.yellow
                        : AppColors.yellow.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
