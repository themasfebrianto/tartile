import 'package:tartile/features/tajwid/domain/entities/tajwid_category_entity.dart';

class TajwidCategoryModel extends TajwidCategoryEntity {
  TajwidCategoryModel({
    required super.id,
    required super.title,
    required super.description,
    required super.icon,
    required super.ordering,
  });

  factory TajwidCategoryModel.fromMap(Map<String, dynamic> map) {
    return TajwidCategoryModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      icon: map['icon'],
      ordering: map['ordering'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'icon': icon,
    'ordering': ordering,
  };

  TajwidCategoryEntity toEntity() {
    return TajwidCategoryEntity(
      id: id,
      title: title,
      description: description,
      icon: icon,
      ordering: ordering,
    );
  }
}
