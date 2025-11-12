import '../../domain/entities/category_entity.dart';

class CategoryMapper {
  // -----------------------
  // Entity → Map (untuk SQLite insert/update)
  // -----------------------
  static Map<String, dynamic> toMap(CategoryEntity category) {
    return {
      'id': category.id,
      'courseId': category.courseId,
      'title': category.title,
      'description': category.description,
      'icon': category.icon,
      'ordering': category.ordering,
      'isLocked': category.isLocked ? 1 : 0,
      'requiredLevel': category.requiredLevel,
      'createdAt': category.createdAt.toIso8601String(),
      'updatedAt': category.updatedAt?.toIso8601String(),
    };
  }

  // -----------------------
  // Map → Entity (dari SQLite)
  // -----------------------
  static CategoryEntity fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      id: map['id']?.toString() ?? '',
      courseId: map['courseId']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      icon: map['icon']?.toString(),
      ordering: _parseInt(map['ordering']),
      isLocked: _parseBool(map['isLocked']),
      requiredLevel: _parseIntNullable(map['requiredLevel']),
      createdAt: _parseDate(map['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDate(map['updatedAt']),
    );
  }

  // -----------------------
  // Helper parsing functions
  // -----------------------

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static int? _parseIntNullable(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) {
      final v = value.toLowerCase();
      return v == 'true' || v == '1';
    }
    return false;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null || value == '') return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
