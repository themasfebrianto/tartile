import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/tajwid/tajwid_feature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tartile - Belajar Tajwid',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light, // from core/theme/app_theme.dart
      home: const TajwidFeature(),
    );
  }
}
