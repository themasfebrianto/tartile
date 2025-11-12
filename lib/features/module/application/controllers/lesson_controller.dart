import 'package:flutter/material.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/repositories/lesson_repository.dart';
import '../../data/dtos/lesson/lesson_filter_dto.dart';

class LessonController extends ChangeNotifier {
  final LessonRepository repository;

  LessonController({required this.repository});

  List<LessonEntity> lessons = [];
  bool loading = false;
  String? error;

  Future<void> loadLessons(LessonFilterDto filter) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      lessons = await repository.getAll(filter);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  /// Bisa filter lokal juga jika perlu
  List<LessonEntity> getLessons(LessonFilterDto filter) {
    return lessons.where((lesson) {
      if (filter.categoryId != null && lesson.categoryId != filter.categoryId) {
        return false;
      }
      if (filter.minXp != null && lesson.xpReward < filter.minXp!) return false;
      if (filter.maxXp != null && lesson.xpReward > filter.maxXp!) return false;
      if (filter.title != null &&
          !lesson.title.toLowerCase().contains(filter.title!.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();
  }
}
