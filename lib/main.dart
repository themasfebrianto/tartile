import 'package:flutter/material.dart';
import 'package:tartile/core/auth/auth_wrapper.dart';
import 'package:tartile/features/Dashboard/dashboard_feature.dart';
import 'package:tartile/features/auth/auth_feature.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tartil.in - Belajar Tajwid',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      themeMode: AppTheme.defaultThemeMode,
      home: AuthWrapper(
        loginScreen: AuthFeature(),
        dashboardScreen: DashboardFeature(),
      ),
    );
  }
}
