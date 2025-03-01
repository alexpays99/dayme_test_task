import 'package:flutter/material.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/game/game_bloc.dart';
import '../bloc/game/game_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.25),
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => context.read<GameBloc>().add(StartGame()),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellow,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 4,
          shadowColor: AppColors.black.withOpacity(0.25),
        ),
        child: Text(
          AppStrings.startButton,
          style: AppTextStyles.mariupolBold32.copyWith(
            color: AppColors.fullBlack,
          ),
        ),
      ),
    );
  }
}
