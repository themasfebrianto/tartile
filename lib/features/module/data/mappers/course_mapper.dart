import 'package:tartile/features/module/domain/entities/course_entity.dart';

class CourseMapper {
  // -----------------------
  // Entity → Map (untuk SQLite insert/update)
  // -----------------------
  static Map<String, dynamic> toMap(CourseEntity course) {
    return {
      'id': course.id,
      'title': course.title,
      'description': course.description,
      'icon': course.icon,
      'ordering': course.ordering,
      'isLocked': course.isLocked ? 1 : 0,
      'createdAt': course.createdAt.toIso8601String(),
      'updatedAt': course.updatedAt?.toIso8601String(),
    };
  }

  // -----------------------
  // Map → Entity (dari SQLite)
  // -----------------------
  static CourseEntity fromMap(Map<String, dynamic> map) {
    return CourseEntity(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      icon: map['icon']?.toString() ?? '',
      ordering: _parseInt(map['ordering']),
      isLocked: _parseBool(map['isLocked']),
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
