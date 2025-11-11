import 'package:flutter/material.dart';
import 'package:tartile/core/theme/app_theme.dart';
import 'package:tartile/features/Dashboard/presentation/widgets/category_widget.dart';
import 'package:tartile/features/Dashboard/presentation/widgets/progress_widget.dart';
import 'package:tartile/features/dashboard/presentation/widgets/app_drawer.dart';
import 'package:tartile/features/tajwid/presentation/screens/category_screen.dart';
import '../../../tajwid/domain/repositories/tajwid_rules_repository.dart';
import '../../../tajwid/domain/repositories/tajwid_category_repository.dart';

class DashboardScreen extends StatefulWidget {
  final TajwidRulesRepository rulesRepository;
  final TajwidCategoryRepository categoryRepository;

  const DashboardScreen({
    super.key,
    required this.rulesRepository,
    required this.categoryRepository,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _progress = 0.0;
  int _streakDays = 0;
  int _completedLessons = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    setState(() {
      _progress = 0.35;
      _streakDays = 5;
      _completedLessons = 12;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            color: colorScheme.onSurface,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'Dashboard',
          style: AppTextStyles.appBarTitle(colorScheme.onSurface),
        ),
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            color: colorScheme.onSurface,
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
        ],
      ),
      drawer: AppDrawer(
        categoryRepository: widget.categoryRepository,
        rulesRepository: widget.rulesRepository,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadProgress();
        },
        color: colorScheme.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Section
              _buildGreetingSection(colorScheme),
              const SizedBox(height: 24),

              // Stats Cards Row
              _buildStatsCards(colorScheme),
              const SizedBox(height: 24),

              // Progress Widget
              ProgressWidget(progress: _progress),
              const SizedBox(height: 24),

              // Quick Practice Card
              _buildQuickPracticeCard(colorScheme),
              const SizedBox(height: 24),

              // Main Category Button
              CategoryButtonWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(
                        rulesRepository: widget.rulesRepository,
                        categoryRepository: widget.categoryRepository,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Recent Learning Section
              _buildRecentLearning(colorScheme),
              const SizedBox(height: 24),

              // Achievements Section
              _buildAchievements(colorScheme),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingSection(ColorScheme colorScheme) {
    final hour = DateTime.now().hour;
    String greeting = 'Selamat Pagi';
    if (hour >= 12 && hour < 15) {
      greeting = 'Selamat Siang';
    } else if (hour >= 15 && hour < 18) {
      greeting = 'Selamat Sore';
    } else if (hour >= 18) {
      greeting = 'Selamat Malam';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurface.withOpacity(0.7),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Mari Belajar Tajwid',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards(ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            colorScheme: colorScheme,
            icon: Icons.local_fire_department_rounded,
            iconColor: Colors.orange,
            value: '$_streakDays',
            label: 'Hari Streak',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            colorScheme: colorScheme,
            icon: Icons.check_circle_rounded,
            iconColor: Colors.green,
            value: '$_completedLessons',
            label: 'Materi Selesai',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            colorScheme: colorScheme,
            icon: Icons.emoji_events_rounded,
            iconColor: Colors.amber,
            value: '${(_progress * 100).toInt()}%',
            label: 'Progress',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required ColorScheme colorScheme,
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPracticeCard(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.quiz_rounded, color: colorScheme.onPrimary, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Latihan Harian',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Uji pemahamanmu dengan kuis singkat setiap hari',
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onPrimary.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              onPressed: () {
                // TODO: Navigate to quiz
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fitur Quiz akan segera hadir!'),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.onPrimary,
                foregroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Mulai Latihan',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentLearning(ColorScheme colorScheme) {
    // TODO: Load dari database
    final recentItems = [
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Belajar Terakhir',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to history
              },
              child: const Text('Lihat Semua'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...recentItems.map(
          (item) => _buildRecentItem(
            colorScheme: colorScheme,
            title: item['title'] as String,
            category: item['category'] as String,
            progress: item['progress'] as double,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentItem({
    required ColorScheme colorScheme,
    required String title,
    required String category,
    required double progress,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigate to specific lesson
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.book_rounded,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: colorScheme.surfaceContainerHigh,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colorScheme.primary,
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurface.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievements(ColorScheme colorScheme) {
    // TODO: Load dari database
    final achievements = [
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pencapaian',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: achievements.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              return _buildAchievementBadge(
                colorScheme: colorScheme,
                icon: achievement['icon'] as IconData,
                color: achievement['color'] as Color,
                label: achievement['label'] as String,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge({
    required ColorScheme colorScheme,
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
