import 'package:flutter/material.dart';
import 'package:tartile/core/theme/app_theme.dart';
import 'package:tartile/features/Dashboard/presentation/widgets/category_widget.dart';
import 'package:tartile/features/Dashboard/presentation/widgets/progress_widget.dart';
import 'package:tartile/features/tajwid/presentation/screens/category_screen.dart';
import 'package:tartile/features/tajwid/presentation/widgets/app_drawer.dart';
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

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    setState(() => _progress = 0.1);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
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
              const SizedBox(height: 24),
              ProgressWidget(progress: _progress),
              const SizedBox(height: 24),
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
            ],
          ),
        ),
      ),
    );
  }
}
