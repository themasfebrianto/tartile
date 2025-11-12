import 'package:tartile/core/utils/base/paginated_response_base.dart';
import 'package:tartile/core/utils/common/app_logger.dart';
import 'package:tartile/features/module/data/data_sources/lesson_local_data_source.dart';
import 'package:tartile/features/module/data/dtos/lesson/lesson_filter_dto.dart';
import 'package:tartile/features/module/domain/entities/lesson_entity.dart';
import 'package:tartile/features/module/domain/repositories/lesson_repository.dart';

class LessonRepositoryImpl extends LessonRepository {
  final LessonLocalDataSource _localDataSource;

  LessonRepositoryImpl(this._localDataSource);

  @override
  Future<List<LessonEntity>> getAll(LessonFilterDto filter) async {
    try {
      return await _localDataSource.getAllLessons(filter);
    } catch (e, st) {
      AppLogger.error('Failed to get all lessons', e, st);
      rethrow;
    }
  }

  @override
  Future<PaginatedResult<LessonEntity>> getAllPaginated(
    LessonFilterDto filter,
  ) async {
    try {
      return await _localDataSource.getAllLessonsPaginated(filter);
    } catch (e, st) {
      AppLogger.error('Failed to get paginated lessons', e, st);
      rethrow;
    }
  }

  @override
  Future<LessonEntity?> getOne(String id) async {
    try {
      final lesson = await _localDataSource.getLessonById(id);
      if (lesson == null) {
        AppLogger.warn('Lesson not found (id: $id)');
      }
      return lesson;
    } catch (e, st) {
      AppLogger.error('Failed to get lesson by id ($id)', e, st);
      rethrow;
    }
  }
}
