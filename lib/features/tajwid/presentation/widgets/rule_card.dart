import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../domain/entities/tajwid_rule_entity.dart';

class TajwidRuleCard extends StatelessWidget {
  final TajwidRuleEntity rule;
  final Color color;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;

  const TajwidRuleCard({
    super.key,
    required this.rule,
    required this.color,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.7), color..withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            subtitle: Text(
              rule.letters,
              style: TextStyle(
                fontFamily: 'NotoSansArabic',
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            title: Text(
              rule.title,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),

            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            initiallyExpanded: isExpanded,
            onExpansionChanged: onExpansionChanged,
            children: [
              // Penjelasan hukum dengan Markdown
              MarkdownBody(
                data: rule.explanation,
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                    .copyWith(
                      p: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
              ),
              const SizedBox(height: 16),
              // Contoh bacaan sebagai nested card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contoh:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: rule.examples.split('\n').map((ayat) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  ayat,
                                  style: TextStyle(
                                    fontFamily: 'ScheherazadeNew',
                                    color: Colors.white,
                                    fontSize: 28,
                                    height: 1.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
