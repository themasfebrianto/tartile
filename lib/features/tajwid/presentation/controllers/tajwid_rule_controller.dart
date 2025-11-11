import 'package:flutter/material.dart';
import '../../domain/entities/tajwid_rule_entity.dart';
import '../../domain/repositories/tajwid_rules_repository.dart';

class TajwidRuleController extends ChangeNotifier {
  final TajwidRulesRepository repository;
  final String categoryId;

  List<TajwidRuleEntity> rules = [];
  bool isLoading = false;
  String? errorMessage;

  int? expandedIndex;

  TajwidRuleController({required this.repository, required this.categoryId});

  Future<void> loadRules() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      rules = await repository.getRulesByCategory(categoryId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleExpansion(int index, bool expanded) {
    if (expanded) {
      expandedIndex = index;
    } else if (expandedIndex == index) {
      expandedIndex = null;
    }
    notifyListeners();
  }
}
