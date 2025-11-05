import 'package:flutter/material.dart';
import 'package:tartile/features/tajwid/data/dataSources/tajwid_category_data_source.dart';
import 'package:tartile/features/tajwid/data/dataSources/tajwid_rules_data_source.dart';
import 'package:tartile/features/tajwid/data/repositories/tajwid_category_repository_impl.dart';
import 'presentation/screens/home_screen.dart';
import 'data/repositories/tajwid_rules_repository_impl.dart';

class TajwidFeature extends StatelessWidget {
  const TajwidFeature({super.key});

  @override
  Widget build(BuildContext context) {
    // You can set up dependencies here
    final rulesDataSource = TajwidRulesDataSource();
    final categoryDataSource = TajwidCategoryDataSource();
    final rulesRepository = TajwidRulesRepositoryImpl(rulesDataSource);
    final categoryRepository = TajwidCategoryRepositoryImpl(categoryDataSource);

    return HomeScreen(
      rulesRepository: rulesRepository,
      categoryRepository: categoryRepository,
    );
  }
}
