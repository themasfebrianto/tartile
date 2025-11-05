// domain/entities/tajwid_category_entity.dart
import 'package:tartile/features/tajwid/domain/entities/tajwid_rule_entity.dart';

class TajwidCategoryEntity {
  final String id;
  final String title;
  final int ordering;
  final List<TajwidRuleEntity>? rules;

  TajwidCategoryEntity({
    required this.id,
    required this.title,
    required this.ordering,
    this.rules,
  });
}
