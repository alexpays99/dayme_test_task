import 'package:flutter/material.dart';

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
    return Column(
      children: [
        LinearProgressIndicator(
          value: currentStep / totalSteps,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
        Text('${currentStep + 1} / $totalSteps'),
      ],
    );
  }
}
