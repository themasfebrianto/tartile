import 'package:flutter/material.dart';
import '../../domain/repositories/tajwid_rules_repository.dart';
import '../../domain/entities/tajwid_rule_entity.dart';
import '../widgets/rule_card.dart';
import 'rule_detail_screen.dart';

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

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: rules.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // dua kolom
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1, // proporsi kartu
              ),
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

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RuleDetailScreen(rule: rule),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: color.withOpacity(0.85),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_book, color: Colors.white, size: 36),
                          const SizedBox(height: 8),
                          Text(
                            rule.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (rule.symbol != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              rule.symbol!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
