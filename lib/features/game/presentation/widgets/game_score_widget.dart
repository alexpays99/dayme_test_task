import 'package:flutter/material.dart';
import '../../../../core/constants/assets.dart';

class GameScoreWidget extends StatelessWidget {
  final int score;

  const GameScoreWidget({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return GameImageAssets.activeCoin.svg;
  }
}
