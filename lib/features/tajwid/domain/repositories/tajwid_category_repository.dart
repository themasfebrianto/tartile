import 'package:tartile/features/tajwid/domain/entities/tajwid_category_entity.dart';

abstract class TajwidCategoryRepository {
  Future<List<TajwidCategoryEntity>> getAllCategories();
}
