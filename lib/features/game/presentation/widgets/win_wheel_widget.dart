import 'package:dayme_test_task/core/constants/assets.dart';
import 'package:dayme_test_task/core/theme/app_theme.dart';
import 'package:dayme_test_task/features/game/presentation/bloc/game/game_bloc.dart';
import 'package:dayme_test_task/features/game/presentation/bloc/game/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WinWheelWidget extends StatelessWidget {
  const WinWheelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.read<GameBloc>().state;
    return Stack(
      alignment: Alignment.center,
      children: [
        GameImageAssets.wheelImg.svg,
        Positioned(
          bottom: 70,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.25),
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text('${state is GameFinished ? state.bonus : 0} бонусів',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.mariupolBold16.copyWith(
                    color: AppColors.fullBlack,
                  )),
            ),
          ),
        ),
        GameImageAssets.coinsImg.svg,
      ],
    );
  }
}
