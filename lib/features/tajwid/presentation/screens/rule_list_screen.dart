import 'package:flutter/material.dart';
import 'package:tartile/features/tajwid/presentation/widgets/rule_card.dart';
import '../../domain/repositories/tajwid_rules_repository.dart';
import '../../domain/entities/tajwid_rule_entity.dart';

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
  late Future<List<TajwidRuleEntity>> _rulesFuture;
  int? _expandedIndex; 

  @override
  void initState() {
    super.initState();
    _rulesFuture = widget.repository.getRulesByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<TajwidRuleEntity>>(
        future: _rulesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final rules = snapshot.data ?? [];
          if (rules.isEmpty) {
            return const Center(child: Text('Belum ada hukum tajwid.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: rules.length,
            itemBuilder: (context, index) {
              final rule = rules[index];
              final colors = [
                Colors.teal,
                Colors.indigo,
                Colors.orange,
                Colors.purple,
                Colors.green,
                Colors.deepOrange,
              ];
              final color = colors[index % colors.length];

              return TajwidRuleCard(
                key: ValueKey(index),
                rule: rule,
                color: color,
                isExpanded: _expandedIndex == index,
                onExpansionChanged: (expanded) {
                  setState(() {
                    if (expanded) {
                      _expandedIndex = index;
                    } else if (_expandedIndex == index) {
                      _expandedIndex = null;
                    }
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
