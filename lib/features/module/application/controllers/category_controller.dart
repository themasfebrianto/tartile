import 'package:flutter/material.dart';
import 'package:tartile/features/module/data/dtos/category/category_filter_dto.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';

class CategoryController extends ChangeNotifier {
  final CategoryRepository repository;

  CategoryController({required this.repository});

  List<CategoryEntity> categories = [];
  bool loading = false;
  String? error;

  Future<void> loadCategories(CategoryFilterDto? filter) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      categories = await repository.getAll(filter ?? CategoryFilterDto());
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  List<CategoryEntity> getCategories(String courseId) {
    return categories.where((c) => c.courseId == courseId).toList();
  }
}
