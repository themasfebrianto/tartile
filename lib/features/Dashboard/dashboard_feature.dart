import 'package:flutter/material.dart';
import 'package:tartile/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:tartile/features/tajwid/data/dataSources/tajwid_category_data_source.dart';
import 'package:tartile/features/tajwid/data/dataSources/tajwid_rules_data_source.dart';
import 'package:tartile/features/tajwid/data/repositories/tajwid_category_repository_impl.dart';
import 'package:tartile/features/tajwid/data/repositories/tajwid_rules_repository_impl.dart';

class DashboardFeature extends StatelessWidget {
  const DashboardFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final rulesDataSource = TajwidRulesDataSource();
    final categoryDataSource = TajwidCategoryDataSource();
    final rulesRepository = TajwidRulesRepositoryImpl(rulesDataSource);
    final categoryRepository = TajwidCategoryRepositoryImpl(categoryDataSource);

    return DashboardScreen(
      rulesRepository: rulesRepository,
      categoryRepository: categoryRepository,
    );
  }
}
