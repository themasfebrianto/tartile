import 'package:tartile/core/utils/base/paginated_response_base.dart';
import 'package:tartile/features/module/data/dtos/lesson/lesson_filter_dto.dart';
import 'package:tartile/features/module/domain/entities/lesson_entity.dart';

abstract class LessonRepository {
  Future<LessonEntity?> getOne(String id);
  Future<List<LessonEntity>> getAll(LessonFilterDto filter);
  Future<PaginatedResult<LessonEntity>> getAllPaginated(
    LessonFilterDto categoryId,
  );
}
