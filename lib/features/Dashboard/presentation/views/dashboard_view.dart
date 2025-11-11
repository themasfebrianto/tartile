import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/core/theme/app_theme.dart';
import 'package:tartile/features/Dashboard/presentation/widgets/category_widget.dart';
import 'package:tartile/features/Dashboard/presentation/widgets/progress_widget.dart';
import 'package:tartile/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:tartile/features/dashboard/presentation/widgets/achievement_badge_widget.dart';
import 'package:tartile/features/dashboard/presentation/widgets/app_drawer.dart';
import 'package:tartile/features/dashboard/presentation/widgets/recent_item_widget.dart';
import 'package:tartile/features/dashboard/presentation/widgets/stat_card_widget.dart';
import 'package:tartile/features/tajwid/presentation/screens/category_screen.dart';
import '../../../tajwid/domain/repositories/tajwid_category_repository.dart';
import '../../../tajwid/domain/repositories/tajwid_rules_repository.dart';

class DashboardView extends StatelessWidget {
  final TajwidRulesRepository rulesRepository;
  final TajwidCategoryRepository categoryRepository;

  const DashboardView({
    super.key,
    required this.rulesRepository,
    required this.categoryRepository,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DashboardController>();
    final colorScheme = Theme.of(context).colorScheme;

    final hour = DateTime.now().hour;
    String greeting = 'Selamat Pagi';
    IconData greetingIcon = Icons.wb_sunny_rounded;

    if (hour >= 12 && hour < 15) {
      greeting = 'Selamat Siang';
      greetingIcon = Icons.wb_sunny_rounded;
    } else if (hour >= 15 && hour < 18) {
      greeting = 'Selamat Sore';
      greetingIcon = Icons.wb_twilight_rounded;
    } else if (hour >= 18) {
      greeting = 'Selamat Malam';
      greetingIcon = Icons.nightlight_round;
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Modern App Bar with Sliver
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu_rounded, color: colorScheme.onSurface),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: colorScheme.onSurface,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          greetingIcon,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          greeting,
                          style: AppTextStyles.body(colorScheme.onSurface)
                              .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mari Belajar Tajwid',
                      style: AppTextStyles.appBarTitle(
                        colorScheme.onSurface,
                      ).copyWith(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: RefreshIndicator(
              onRefresh: controller.loadProgress,
              color: colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Stats Cards - Using existing StatCardWidget
                    Row(
                      children: [
                        Expanded(
                          child: StatCardWidget(
                            icon: Icons.local_fire_department_rounded,
                            iconColor: const Color(0xFFFF6B35),
                            value: '${controller.streakDays}',
                            label: 'Hari Streak',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCardWidget(
                            icon: Icons.check_circle_rounded,
                            iconColor: const Color(0xFF34C759),
                            value: '${controller.completedLessons}',
                            label: 'Selesai',
                          ),
                        ),
                        const SizedBox(width: 12),
                        StatCardWidget(
                          icon: Icons.emoji_events_rounded,
                          iconColor: Colors.amber,
                          value: '${(controller.progress * 100).toInt()}%',
                          label: 'Progress Total',
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Single stat card for progress

                    // Progress Widget - Using existing widget
                    ProgressWidget(progress: controller.progress),
                    const SizedBox(height: 20),

                    // Quick Practice Card - Google Style
                    _QuickPracticeCard(
                      colorScheme: colorScheme,
                      onTap: () {
                        // Navigate to practice
                      },
                    ),
                    const SizedBox(height: 20),

                    // Category Button - Using existing widget
                    CategoryButtonWidget(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryScreen(
                              rulesRepository: rulesRepository,
                              categoryRepository: categoryRepository,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    // Recent Learning Section
                    _SectionHeader(
                      title: 'Belajar Terakhir',
                      onSeeAll: () {},
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 12),
                    ...controller.recentItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: RecentItemWidget(
                          title: item['title'],
                          category: item['category'],
                          progress: item['progress'],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Achievements Section
                    _SectionHeader(
                      title: 'Pencapaian',
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 110,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemCount: controller.achievements.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, index) {
                          final ach = controller.achievements[index];
                          return AchievementBadgeWidget(
                            icon: ach['icon'],
                            color: ach['color'],
                            label: ach['label'],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(
        categoryRepository: categoryRepository,
        rulesRepository: rulesRepository,
      ),
    );
  }
}

// Quick Practice Card - Google Style
class _QuickPracticeCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _QuickPracticeCard({required this.colorScheme, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.primary.withValues(alpha: 0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.quiz_rounded,
                    color: colorScheme.onPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Latihan Harian',
                        style: AppTextStyles.body(
                          colorScheme.onPrimary,
                        ).copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Uji pemahamanmu dengan kuis singkat',
                        style: AppTextStyles.body(colorScheme.onPrimary)
                            .copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: colorScheme.onPrimary.withValues(
                                alpha: 0.9,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: colorScheme.onPrimary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Section Header
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  final ColorScheme colorScheme;

  const _SectionHeader({
    required this.title,
    this.onSeeAll,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.body(
            colorScheme.onSurface,
          ).copyWith(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Lihat Semua',
              style: AppTextStyles.body(
                colorScheme.primary,
              ).copyWith(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}
