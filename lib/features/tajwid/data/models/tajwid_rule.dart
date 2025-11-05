import '../../domain/entities/tajwid_rule_entity.dart';

class TajwidRuleModel extends TajwidRuleEntity {
  TajwidRuleModel({
    required super.id,
    required super.categoryId,
    required super.title,
    required super.symbol,
    required super.detailMd,
    super.audioUrl,
  });

  factory TajwidRuleModel.fromMap(Map<String, dynamic> map) {
    return TajwidRuleModel(
      id: map['id'],
      categoryId: map['categoryId'],
      title: map['title'],
      symbol: map['symbol'],
      detailMd: map['detailMd'],
      audioUrl: map['audioUrl'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'categoryId': categoryId,
    'title': title,
    'symbol': symbol,
    'detailMd': detailMd,
    'audioUrl': audioUrl,
  };

  TajwidRuleEntity toEntity() {
    return TajwidRuleEntity(
      id: id,
      title: title,
      symbol: symbol,
      detailMd: detailMd,
      audioUrl: audioUrl,
      categoryId: categoryId,
    );
  }
}
