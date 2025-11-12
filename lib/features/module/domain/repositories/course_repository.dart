import 'package:tartile/core/utils/base/paginated_response_base.dart';
import 'package:tartile/features/module/data/dtos/course/course_filter_dto.dart';
import 'package:tartile/features/module/domain/entities/course_entity.dart';

abstract class CourseRepository {
  Future<CourseEntity?> getOne(String id);
  Future<List<CourseEntity>> getAll(CourseFilterDto filter);
  Future<PaginatedResult<CourseEntity>> getAllPaginated(
    CourseFilterDto categoryId,
  );
}
