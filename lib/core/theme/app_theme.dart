import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightScaffoldBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightAppBarBackground,
      foregroundColor: AppColors.lightAppBarForeground,
    ),
    textTheme: Typography.blackMountainView.copyWith(
      bodyMedium: const TextStyle(color: AppColors.lightTextPrimary),
      bodySmall: const TextStyle(color: AppColors.lightTextSecondary),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkAppBarBackground,
      foregroundColor: AppColors.darkAppBarForeground,
    ),
    textTheme: Typography.whiteMountainView.copyWith(
      bodyMedium: const TextStyle(color: AppColors.darkTextPrimary),
      bodySmall: const TextStyle(color: AppColors.darkTextSecondary),
    ),
  );
}
