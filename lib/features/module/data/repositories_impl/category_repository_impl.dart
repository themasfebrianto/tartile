import 'package:tartile/core/utils/base/paginated_response_base.dart';
import 'package:tartile/core/utils/common/app_logger.dart';
import 'package:tartile/features/module/data/data_sources/category_local_data_source.dart';
import 'package:tartile/features/module/data/dtos/category/category_filter_dto.dart';
import 'package:tartile/features/module/domain/entities/category_entity.dart';
import 'package:tartile/features/module/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryLocalDataSource _localDataSource;

  CategoryRepositoryImpl(this._localDataSource);

  @override
  Future<List<CategoryEntity>> getAll(CategoryFilterDto filter) async {
    try {
      return await _localDataSource.getAllCategories(filter);
    } catch (e, st) {
      AppLogger.error('Failed to get all categorys', e, st);
      rethrow;
    }
  }

  @override
  Future<PaginatedResult<CategoryEntity>> getAllPaginated(
    CategoryFilterDto filter,
  ) async {
    try {
      return await _localDataSource.getAllCategoriesPaginated(filter);
    } catch (e, st) {
      AppLogger.error('Failed to get paginated categorys', e, st);
      rethrow;
    }
  }

  @override
  Future<CategoryEntity?> getOne(String id) async {
    try {
      final category = await _localDataSource.getCategoryById(id);
      if (category == null) {
        AppLogger.warn('Category not found (id: $id)');
      }
      return category;
    } catch (e, st) {
      AppLogger.error('Failed to get category by id ($id)', e, st);
      rethrow;
    }
  }
}
