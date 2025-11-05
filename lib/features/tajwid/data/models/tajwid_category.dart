import 'package:tartile/features/tajwid/domain/entities/tajwid_category_entity.dart';

class TajwidCategoryModel extends TajwidCategoryEntity {
  TajwidCategoryModel({
    required super.id,
    required super.title,
    required super.ordering,
    required super.rules,
  });

  factory TajwidCategoryModel.fromMap(Map<String, dynamic> map) {
    return TajwidCategoryModel(
      id: map['id'],
      title: map['title'],
      ordering: map['ordering'],
      rules: map['rules'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'ordering': ordering,
    'rules': rules,
  };

  TajwidCategoryEntity toEntity() {
    return TajwidCategoryEntity(
      id: id,
      title: title,
      ordering: ordering,
      rules: rules,
    );
  }
}
