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

  factory TajwidRuleModel.fromMap(Map<String, dynamic> map) {
    return TajwidRuleModel(
      id: map['id'],
      categoryId: map['categoryId'],
      title: map['title'],
      explanation: map['explanation'] ?? '',
      letters: map['letters'] ?? '',
      examples: map['examples'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'categoryId': categoryId,
    'title': title,
    'explanation': explanation,
    'letters': letters,
    'examples': examples,
  };

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
