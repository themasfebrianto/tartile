import 'package:tartile/core/utils/base/paginated_response_base.dart';
import 'package:tartile/core/utils/common/sqlite_db_context.dart';
import 'package:tartile/core/utils/common/sqlite_table.dart';
import 'package:tartile/features/module/data/dtos/course/course_filter_dto.dart';
import 'package:tartile/features/module/data/mappers/course_mapper.dart';
import '../../domain/entities/course_entity.dart';
import 'package:tartile/core/constants/database_settings.dart';
import 'package:sqflite/sqflite.dart';

class CourseLocalDataSource {
  static const _tableName = DatabaseSettings.tableCourses;

  final SQLiteTable _table;

  CourseLocalDataSource() : _table = SQLiteTable(_tableName) {
    SQLiteDbContext.registerTable(_onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        icon TEXT NOT NULL,
        ordering INTEGER NOT NULL,
        isLocked INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT
      )
    ''');
  }

  // ----------------------------------------------------------
  // CRUD OPERATIONS
  // ----------------------------------------------------------

  Future<void> insertCourse(CourseEntity course) async {
    await _table.insert(CourseMapper.toMap(course));
  }

  Future<void> insertCourses(List<CourseEntity> courses) async {
    for (final course in courses) {
      await _table.insert(CourseMapper.toMap(course));
    }
  }

  Future<List<CourseEntity>> getAllCourses(CourseFilterDto filter) async {
    final maps = await _table.findAll(orderBy: filter.sortBy ?? 'ordering ASC');
    return maps
        .map((e) => CourseMapper.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<PaginatedResult<CourseEntity>> getAllCoursesPaginated(
    CourseFilterDto filter,
  ) async {
    final result = await _table.findPaginated(
      page: filter.page ?? 1,
      limit: filter.limit ?? 10,
      orderBy: filter.sortBy ?? 'ordering ASC',
    );

    final data = result.data
        .map((e) => CourseMapper.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    return PaginatedResult(data: data, metaPagination: result.metaPagination);
  }

  Future<CourseEntity?> getCourseById(String id) async {
    final map = await _table.findOne(where: 'id = ?', whereArgs: [id]);
    if (map == null) return null;
    return CourseMapper.fromMap(Map<String, dynamic>.from(map));
  }

  Future<int> updateCourse(CourseEntity course) async {
    return await _table.update(
      CourseMapper.toMap(course),
      where: 'id = ?',
      whereArgs: [course.id],
    );
  }

  Future<int> deleteCourse(String id) async {
    return await _table.delete(where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCourses() async {
    await _table.clear();
  }
}
