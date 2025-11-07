import 'package:flutter/material.dart';
import 'package:tartile/core/constants/app_colors.dart';

// Text styles
class AppTextStyles {
  static TextStyle appBarTitle(Color onSurfaceColor) {
    return TextStyle(
      color: onSurfaceColor,
      fontSize: 22,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle body(Color onSurfaceColor) {
    return TextStyle(color: onSurfaceColor, fontSize: 16);
  }
}

// AppTheme with light and dark
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          surface: AppColors.lightSurface,
          onSurface: Colors.black87,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
    scaffoldBackgroundColor: AppColors.lightSurface,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ).copyWith(
          surface: AppColors.darkSurface,
          onSurface: Colors.white70,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
    scaffoldBackgroundColor: AppColors.darkSurface,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    useMaterial3: true,
  );

  // Follow system theme by default
  static ThemeMode defaultThemeMode = ThemeMode.system;
}
