import 'package:flutter/material.dart';
import 'package:tartile/features/tajwid/domain/entities/tajwid_rule_entity.dart';

class RuleCard extends StatelessWidget {
  final TajwidRuleEntity rule;
  final VoidCallback onTap;

  const RuleCard({super.key, required this.rule, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          rule.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          rule.detailMd,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
