import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:tartile/features/dashboard/presentation/views/dashboard_view.dart';
import '../../../tajwid/domain/repositories/tajwid_category_repository.dart';
import '../../../tajwid/domain/repositories/tajwid_rules_repository.dart';

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
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = DashboardController(
      rulesRepository: widget.rulesRepository,
      categoryRepository: widget.categoryRepository,
    );
    controller.loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardController>.value(
      value: controller,
      child: DashboardView(
        rulesRepository: widget.rulesRepository,
        categoryRepository: widget.categoryRepository,
      ),
    );
  }
}
