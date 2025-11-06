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
    final colorScheme = Theme.of(context).colorScheme;

    final colors = [
      const Color(0xFFBBDEFB), // Light Blue 100
      const Color(0xFFC8E6C9), // Green 100
      const Color(0xFFFFF9C4), // Yellow 100
      const Color(0xFFFFCCBC), // Deep Orange 100
      const Color(0xFFD1C4E9), // Deep Purple 100
      const Color(0xFFFFF3E0), // Orange 50
      const Color(0xFFE1BEE7), // Purple 100
      const Color(0xFFDCEDC8), // Lime 100
    ];

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: colorScheme.onSurface,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.categoryName,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder<List<TajwidRuleEntity>>(
        future: _rulesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64,
                      color: colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Terjadi Kesalahan',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: colorScheme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final rules = snapshot.data ?? [];

          if (rules.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_rounded,
                    size: 64,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada hukum tajwid',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: rules.length,
            itemBuilder: (context, index) {
              final rule = rules[index];
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
