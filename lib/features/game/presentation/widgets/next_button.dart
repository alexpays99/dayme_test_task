import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/game/game_bloc.dart';
import '../bloc/game/game_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: ElevatedButton(
          onPressed: () => context.read<GameBloc>().add(NextStep()),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 4,
            shadowColor: AppColors.black.withOpacity(0.25),
          ),
          child: const Text(
            'Далі',
            style: AppTextStyles.mariupolBold32,
          ),
        ),
      ),
    );
  }
}
