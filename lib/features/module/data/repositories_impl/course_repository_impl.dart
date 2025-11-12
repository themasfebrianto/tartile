import 'package:tartile/core/utils/base/paginated_response_base.dart';
import 'package:tartile/core/utils/common/app_logger.dart';
import 'package:tartile/features/module/data/data_sources/course_local_data_source.dart';
import 'package:tartile/features/module/data/dtos/course/course_filter_dto.dart';
import 'package:tartile/features/module/domain/entities/course_entity.dart';
import 'package:tartile/features/module/domain/repositories/course_repository.dart';

class CourseRepositoryImpl extends CourseRepository {
  final CourseLocalDataSource _localDataSource;

  CourseRepositoryImpl(this._localDataSource);

  @override
  Future<List<CourseEntity>> getAll(CourseFilterDto filter) async {
    try {
      return await _localDataSource.getAllCourses(filter);
    } catch (e, st) {
      AppLogger.error('Failed to get all courses', e, st);
      rethrow;
    }
  }

  @override
  Future<PaginatedResult<CourseEntity>> getAllPaginated(
    CourseFilterDto filter,
  ) async {
    try {
      return await _localDataSource.getAllCoursesPaginated(filter);
    } catch (e, st) {
      AppLogger.error('Failed to get paginated courses', e, st);
      rethrow;
    }
  }

  @override
  Future<CourseEntity?> getOne(String id) async {
    try {
      final course = await _localDataSource.getCourseById(id);
      if (course == null) {
        AppLogger.warn('Course not found (id: $id)');
      }
      return course;
    } catch (e, st) {
      AppLogger.error('Failed to get course by id ($id)', e, st);
      rethrow;
    }
  }
}
