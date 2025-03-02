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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width - 32, // Account for padding
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(totalSteps, (index) {
                final isCompleted = index < currentStep;
                final isCurrent = index == currentStep;
                return Expanded(
                  child: Container(
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      gradient: isCompleted || isCurrent
                          ? const LinearGradient(
                              colors: [
                                AppColors.yellowLight,
                                AppColors.yellowDark,
                              ],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        width: 2,
                        color: isCompleted || isCurrent
                            ? AppColors.brownDark
                            : AppColors.yellow.withOpacity(0.25),
                      ),
                      boxShadow: isCompleted || isCurrent
                          ? [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.25),
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
