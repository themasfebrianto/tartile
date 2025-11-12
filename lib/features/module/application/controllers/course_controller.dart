import 'package:flutter/material.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/course_repository.dart';
import '../../data/dtos/course/course_filter_dto.dart';

class CourseController extends ChangeNotifier {
  final CourseRepository repository;

  CourseController({required this.repository});

  List<CourseEntity> courses = [];
  bool loading = false;
  String? error;

  Future<void> loadCourses({CourseFilterDto? filter}) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      courses = await repository.getAll(filter ?? CourseFilterDto());
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCourses({CourseFilterDto? filter}) async {
    await loadCourses(filter: filter);
  }
}
