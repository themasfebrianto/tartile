import 'package:flutter/material.dart';
import '../../../tajwid/domain/repositories/tajwid_category_repository.dart';
import '../../../tajwid/domain/repositories/tajwid_rules_repository.dart';

class DashboardController extends ChangeNotifier {
  final TajwidRulesRepository rulesRepository;
  final TajwidCategoryRepository categoryRepository;

  // Stats
  double progress = 0.0;
  int streakDays = 0;
  int completedLessons = 0;

  // Recent Learning
  List<Map<String, dynamic>> recentItems = [];

  // Achievements
  List<Map<String, dynamic>> achievements = [];

  DashboardController({
    required this.rulesRepository,
    required this.categoryRepository,
  });

  Future<void> loadProgress() async {
    // TODO: replace with real DB/API calls
    progress = 0.35;
    streakDays = 5;
    completedLessons = 12;

    recentItems = [
      {
        'title': 'Hukum Nun Mati',
        'category': 'Nun Mati & Tanwin',
        'progress': 0.8,
      },
      {
        'title': 'Idgham Bighunnah',
        'category': 'Nun Mati & Tanwin',
        'progress': 0.6,
      },
      {'title': 'Qalqalah Kubra', 'category': 'Qalqalah', 'progress': 0.4},
    ];

    achievements = [
      {'icon': Icons.star_rounded, 'color': Colors.amber, 'label': 'Pemula'},
      {
        'icon': Icons.workspace_premium_rounded,
        'color': Colors.blue,
        'label': 'Konsisten',
      },
      {
        'icon': Icons.military_tech_rounded,
        'color': Colors.purple,
        'label': 'Master',
      },
    ];

    notifyListeners();
  }
}
