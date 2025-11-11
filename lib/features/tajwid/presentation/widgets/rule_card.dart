import 'dart:convert';
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
    final colorScheme = Theme.of(context).colorScheme;

    Map<String, String> examplesMap = {};
    if (rule.examples.isNotEmpty) {
      final decoded = jsonDecode(rule.examples) as Map<String, dynamic>;
      examplesMap = decoded.map((k, v) => MapEntry(k, v.toString()));
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.white.withValues(alpha: 0.1),
            highlightColor: Colors.white.withValues(alpha: 0.05),
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                rule.letters,
                style: TextStyle(
                  fontFamily: 'NotoSansArabic',
                  color: colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),
            title: Text(
              rule.title,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
                fontSize: 17,
                letterSpacing: 0.1,
              ),
            ),
            childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            initiallyExpanded: isExpanded,
            onExpansionChanged: onExpansionChanged,
            children: [
              const SizedBox(height: 8),
              MarkdownBody(
                data: rule.explanation,
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                    .copyWith(
                      p: TextStyle(
                        fontFamily: 'Poppins',
                        color: colorScheme.onPrimaryContainer.withValues(
                          alpha: 0.8,
                        ),
                        fontSize: 15,
                        height: 1.6,
                        letterSpacing: 0.2,
                      ),
                    ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimaryContainer.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            color: colorScheme.onPrimaryContainer.withValues(
                              alpha: 0.4,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Contoh',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Wrap(
                        spacing: 24, // jarak antar kolom
                        runSpacing: 20, // jarak antar baris
                        alignment: WrapAlignment.center,
                        children: examplesMap.entries.map((entry) {
                          return SizedBox(
                            width:
                                MediaQuery.of(context).size.width /
                                2.5, // dua kolom kira-kira
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  entry.key,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'ScheherazadeNew',
                                    color: colorScheme.onPrimaryContainer,
                                    fontSize: 28,
                                    height: 1.8,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  entry.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: colorScheme.onPrimaryContainer
                                        .withValues(alpha: 0.7),
                                    fontSize: 14,
                                    height: 1.5,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
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
