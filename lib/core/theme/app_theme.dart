import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFAE7FFF);
  static const text = Color(0xFFFFFFFF);
  static const yellow = Color(0xFFF1FF8B);
  static const purple = Color(0xFF9A7FFF);
  static const white = Color(0xFFFFFFFF);
  static const black = Color.fromARGB(255, 0, 0, 0);
}

class AppTextStyles {
  static const mariupolBold32 = TextStyle(
    fontFamily: 'Mariupol',
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const mariupolBold20 = TextStyle(
    fontFamily: 'Mariupol',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const mariupolBold16 = TextStyle(
    fontFamily: 'Mariupol',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static const mariupolBold14 = TextStyle(
    fontFamily: 'Mariupol',
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
}

class AppTheme {
  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.purple,
          surface: AppColors.background,
        ),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
        fontFamily: 'Mariupol',
        textTheme: const TextTheme(
          displayLarge: AppTextStyles.mariupolBold32,
          titleLarge: AppTextStyles.mariupolBold20,
          bodyLarge: AppTextStyles.mariupolBold16,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.yellow,
            foregroundColor: AppColors.purple,
            textStyle: AppTextStyles.mariupolBold16,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      );
}
