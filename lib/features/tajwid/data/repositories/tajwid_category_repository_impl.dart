import 'package:tartile/features/tajwid/data/dataSources/tajwid_category_data_source.dart';
import 'package:tartile/features/tajwid/data/models/tajwid_category.dart';
import 'package:tartile/features/tajwid/domain/entities/tajwid_category_entity.dart';
import 'package:tartile/features/tajwid/domain/repositories/tajwid_category_repository.dart';

class TajwidCategoryRepositoryImpl implements TajwidCategoryRepository {
  final TajwidCategoryDataSource dataSource;

  TajwidCategoryRepositoryImpl(this.dataSource);

  @override
  Future<List<TajwidCategoryEntity>> getAllCategories() async {
    final models = await dataSource.getAllCategories();
    return models
        .map((m) => TajwidCategoryModel.fromMap(m).toEntity())
        .toList();
  }
}
