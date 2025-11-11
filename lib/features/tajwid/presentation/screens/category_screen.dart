import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/features/tajwid/presentation/controllers/tajwid_category_controller.dart';
import 'package:tartile/features/tajwid/presentation/views/category_view.dart';
import '../../domain/repositories/tajwid_category_repository.dart';
import '../../domain/repositories/tajwid_rules_repository.dart';

class CategoryScreen extends StatefulWidget {
  final TajwidRulesRepository rulesRepository;
  final TajwidCategoryRepository categoryRepository;

  const CategoryScreen({
    super.key,
    required this.rulesRepository,
    required this.categoryRepository,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late TajwidCategoryController controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller = TajwidCategoryController(
      tajwidRulesRepository: widget.rulesRepository,
      tajwidCategoryRepository: widget.categoryRepository,
    );
    controller.loadCategories();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      controller.search(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TajwidCategoryController>.value(
      value: controller,
      child: CategoryView(onSearchChanged: _onSearchChanged),
    );
  }
}
