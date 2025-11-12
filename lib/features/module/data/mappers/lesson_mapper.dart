import 'package:tartile/features/module/domain/entities/lesson_entity.dart';

class LessonMapper {
  // -----------------------
  // Entity → Map (untuk SQLite insert/update)
  // -----------------------
  static Map<String, dynamic> toMap(LessonEntity lesson) {
    return {
      'id': lesson.id,
      'categoryId': lesson.categoryId,
      'title': lesson.title,
      'content': lesson.content,
      'videoUrl': lesson.videoUrl,
      'audioUrl': lesson.audioUrl,
      'ordering': lesson.ordering,
      'estimatedMinutes': lesson.estimatedMinutes,
      'xpReward': lesson.xpReward,
      'createdAt': lesson.createdAt.toIso8601String(),
      'updatedAt': lesson.updatedAt?.toIso8601String(),
    };
  }

  // -----------------------
  // Map → Entity (dari SQLite)
  // -----------------------
  static LessonEntity fromMap(Map<String, dynamic> map) {
    return LessonEntity(
      id: map['id']?.toString() ?? '',
      categoryId: map['categoryId']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      videoUrl: map['videoUrl']?.toString(),
      audioUrl: map['audioUrl']?.toString(),
      ordering: _parseInt(map['ordering']),
      estimatedMinutes: _parseInt(map['estimatedMinutes']),
      xpReward: _parseInt(map['xpReward']),
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

  static DateTime? _parseDate(dynamic value) {
    if (value == null || value == '') return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
