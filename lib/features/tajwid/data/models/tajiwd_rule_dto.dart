import 'dart:convert';

import 'package:tartile/features/tajwid/data/models/tajwid_rule.dart';

class TajwidRuleDto {
  final String id;
  final String categoryId;
  final String title;
  final String explanation;
  final String letters;
  final Map<String, String> examples;

  const TajwidRuleDto({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.explanation,
    required this.letters,
    required this.examples,
  });

  TajwidRuleModel toModel() => TajwidRuleModel(
    id: id,
    categoryId: categoryId,
    title: title,
    explanation: explanation,
    letters: letters,
    examples: jsonEncode(examples),
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'explanation': explanation,
      'letters': letters,
      'examples': jsonEncode(examples), // sudah JSON string
    };
  }
}
