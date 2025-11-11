import 'package:flutter/material.dart';
import 'package:tartile/features/tajwid/domain/entities/tajwid_category_entity.dart';
import 'package:tartile/features/tajwid/domain/repositories/tajwid_category_repository.dart';
import 'package:tartile/features/tajwid/domain/repositories/tajwid_rules_repository.dart';

class TajwidCategoryController extends ChangeNotifier {
  final TajwidRulesRepository tajwidRulesRepository;
  final TajwidCategoryRepository tajwidCategoryRepository;

  List<TajwidCategoryEntity> allCategories = [];
  List<TajwidCategoryEntity> filteredCategories = [];
  bool isLoading = false;
  String query = '';
  String? errorMessage;

  TajwidCategoryController({
    required this.tajwidRulesRepository,
    required this.tajwidCategoryRepository,
  });

  Future<void> loadCategories() async {
    isLoading = true;
    notifyListeners();
    try {
      final categories = await tajwidCategoryRepository.getAllCategories();
      allCategories = categories;
      filteredCategories = categories;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void search(String value) {
    query = value;
    if (query.isEmpty) {
      filteredCategories = allCategories;
    } else {
      filteredCategories = allCategories
          .where((cat) => cat.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
