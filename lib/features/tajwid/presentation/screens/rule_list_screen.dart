import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/features/tajwid/presentation/controllers/tajwid_rule_controller.dart';
import 'package:tartile/features/tajwid/presentation/views/rule_view.dart';
import '../../domain/repositories/tajwid_rules_repository.dart';

class RuleListScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final TajwidRulesRepository repository;

  const RuleListScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.repository,
  });

  @override
  State<RuleListScreen> createState() => _RuleListScreenState();
}

class _RuleListScreenState extends State<RuleListScreen> {
  late TajwidRuleController controller;

  @override
  void initState() {
    super.initState();
    controller = TajwidRuleController(
      repository: widget.repository,
      categoryId: widget.categoryId,
    );
    controller.loadRules();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TajwidRuleController>.value(
      value: controller,
      child: RuleView(categoryName: widget.categoryName),
    );
  }
}
