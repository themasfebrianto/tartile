import 'package:tartile/core/utils/base/paginated_response_base.dart';
import 'package:tartile/core/utils/common/sqlite_db_context.dart';
import 'package:tartile/core/utils/common/sqlite_table.dart';
import 'package:tartile/features/module/data/dtos/lesson/lesson_filter_dto.dart';
import 'package:tartile/features/module/data/mappers/lesson_mapper.dart';
import '../../domain/entities/lesson_entity.dart';
import 'package:tartile/core/constants/database_settings.dart';
import 'package:sqflite/sqflite.dart';

class LessonLocalDataSource {
  static const _tableName = DatabaseSettings.tableLessons;

  final SQLiteTable _table;

  LessonLocalDataSource() : _table = SQLiteTable(_tableName) {
    SQLiteDbContext.registerTable(_onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableName (
      id TEXT PRIMARY KEY,
      categoryId TEXT NOT NULL,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      videoUrl TEXT,
      audioUrl TEXT,
      ordering INTEGER NOT NULL,
      estimatedMinutes INTEGER NOT NULL,
      xpReward INTEGER NOT NULL DEFAULT 10,
      createdAt TEXT NOT NULL,
      updatedAt TEXT
    )
  ''');
  }

  // ----------------------------------------------------------
  // CRUD OPERATIONS
  // ----------------------------------------------------------

  Future<void> insertLesson(LessonEntity lesson) async {
    await _table.insert(LessonMapper.toMap(lesson));
  }

  Future<void> insertLessons(List<LessonEntity> lessons) async {
    for (final lesson in lessons) {
      await _table.insert(LessonMapper.toMap(lesson));
    }
  }

  Future<List<LessonEntity>> getAllLessons(LessonFilterDto filter) async {
    final maps = await _table.findAll(orderBy: filter.sortBy ?? 'ordering ASC');
    return maps
        .map((e) => LessonMapper.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<PaginatedResult<LessonEntity>> getAllLessonsPaginated(
    LessonFilterDto filter,
  ) async {
    final result = await _table.findPaginated(
      page: filter.page ?? 1,
      limit: filter.limit ?? 10,
      orderBy: filter.sortBy ?? 'ordering ASC',
    );

    final data = result.data
        .map((e) => LessonMapper.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    return PaginatedResult(data: data, metaPagination: result.metaPagination);
  }

  Future<LessonEntity?> getLessonById(String id) async {
    final map = await _table.findOne(where: 'id = ?', whereArgs: [id]);
    if (map == null) return null;
    return LessonMapper.fromMap(Map<String, dynamic>.from(map));
  }

  Future<int> updateLesson(LessonEntity lesson) async {
    return await _table.update(
      LessonMapper.toMap(lesson),
      where: 'id = ?',
      whereArgs: [lesson.id],
    );
  }

  Future<int> deleteLesson(String id) async {
    return await _table.delete(where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearLessons() async {
    await _table.clear();
  }
}
