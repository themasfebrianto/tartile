import 'package:tartile/core/utils/base/paginated_response_base.dart';
import 'package:tartile/features/module/data/dtos/category/category_filter_dto.dart';
import 'package:tartile/features/module/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<CategoryEntity?> getOne(String id);
  Future<List<CategoryEntity>> getAll(CategoryFilterDto filter);
  Future<PaginatedResult<CategoryEntity>> getAllPaginated(
    CategoryFilterDto courseId,
  );
}
