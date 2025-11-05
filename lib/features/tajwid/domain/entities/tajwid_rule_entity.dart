// domain/entities/tajwid_rule_entity.dart
class TajwidRuleEntity {
  final String id;
  final String categoryId;
  final String title;
  final String symbol;
  final String detailMd;
  final String? audioUrl;

  TajwidRuleEntity({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.symbol,
    required this.detailMd,
    this.audioUrl,
  });
}
