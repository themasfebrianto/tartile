import 'dart:convert';
import '../../domain/entities/tajwid_rule_entity.dart';

class TajwidRuleModel extends TajwidRuleEntity {
  TajwidRuleModel({
    required super.id,
    required super.categoryId,
    required super.title,
    required super.explanation,
    required super.letters,
    required super.examples,
  });

  /// Buat dari Map DB atau seeder
  factory TajwidRuleModel.fromMap(Map<String, dynamic> map) {
    Map<String, String> examplesMap = {};

    final rawExamples = map['examples'];

    if (rawExamples != null) {
      if (rawExamples is String && rawExamples.isNotEmpty) {
        // dari DB: JSON string -> Map
        final decoded = jsonDecode(rawExamples) as Map<String, dynamic>;
        examplesMap = decoded.map((k, v) => MapEntry(k, v.toString()));
      } else if (rawExamples is Map) {
        // dari seeder: Map langsung
        examplesMap = Map<String, String>.from(rawExamples);
      }
    }

    return TajwidRuleModel(
      id: map['id'] as String,
      categoryId: map['categoryId'] as String,
      title: map['title'] as String,
      explanation: map['explanation'] as String? ?? '',
      letters: map['letters'] as String? ?? '',
      examples: jsonEncode(examplesMap),
    );
  }

  /// Convert ke Map untuk DB
  Map<String, dynamic> toMap() => {
    'id': id,
    'categoryId': categoryId,
    'title': title,
    'explanation': explanation,
    'letters': letters,
    'examples': jsonEncode(examples),
  };

  /// Convert ke Entity
  TajwidRuleEntity toEntity() {
    return TajwidRuleEntity(
      id: id,
      categoryId: categoryId,
      title: title,
      explanation: explanation,
      letters: letters,
      examples: examples,
    );
  }
}
