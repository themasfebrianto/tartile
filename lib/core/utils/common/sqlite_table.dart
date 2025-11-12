import 'package:sqflite/sqflite.dart';
import 'package:tartile/core/utils/common/sqlite_db_context.dart';
import 'package:tartile/core/utils/common/app_logger.dart';
import 'package:tartile/core/utils/base/paginated_response_base.dart';

/// Wrapper sederhana untuk operasi CRUD berbasis tabel SQLite.
class SQLiteTable {
  final String tableName;

  const SQLiteTable(this.tableName);

  // --------------------------------------------------------------------------
  // BASIC CRUD
  // --------------------------------------------------------------------------

  Future<int> insert(
    Map<String, dynamic> data, {
    ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.replace,
  }) async {
    try {
      final db = await SQLiteDbContext.database;
      return await db.insert(
        tableName,
        data,
        conflictAlgorithm: conflictAlgorithm,
      );
    } catch (e, st) {
      AppLogger.error('Failed to insert into $tableName', e, st);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> findAll({
    String? orderBy,
    int? limit,
    int? offset,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final db = await SQLiteDbContext.database;
      return await db.query(
        tableName,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e, st) {
      AppLogger.error('Failed to query $tableName', e, st);
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> findOne({
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final result = await findAll(where: where, whereArgs: whereArgs, limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> update(
    Map<String, dynamic> data, {
    required String where,
    required List<Object?> whereArgs,
  }) async {
    try {
      final db = await SQLiteDbContext.database;
      return await db.update(
        tableName,
        data,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e, st) {
      AppLogger.error('Failed to update $tableName', e, st);
      rethrow;
    }
  }

  Future<int> delete({
    required String where,
    required List<Object?> whereArgs,
  }) async {
    try {
      final db = await SQLiteDbContext.database;
      return await db.delete(tableName, where: where, whereArgs: whereArgs);
    } catch (e, st) {
      AppLogger.error('Failed to delete from $tableName', e, st);
      rethrow;
    }
  }

  Future<void> clear() async {
    try {
      final db = await SQLiteDbContext.database;
      await db.delete(tableName);
    } catch (e, st) {
      AppLogger.error('Failed to clear $tableName', e, st);
      rethrow;
    }
  }

  // --------------------------------------------------------------------------
  // PAGINATION SUPPORT
  // --------------------------------------------------------------------------

  Future<PaginatedResult<Map<String, dynamic>>> findPaginated({
    int? page,
    int? limit,
    String? orderBy,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final safePage = (page ?? 1) < 1 ? 1 : (page ?? 1);
    final safeLimit = (limit ?? 10) <= 0 ? 10 : (limit ?? 10);
    final offset = (safePage - 1) * safeLimit;

    try {
      final db = await SQLiteDbContext.database;

      // total count
      final totalQuery = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $tableName',
      );
      final totalItems = Sqflite.firstIntValue(totalQuery) ?? 0;

      // paged data
      final maps = await findAll(
        orderBy: orderBy,
        limit: safeLimit,
        offset: offset,
        where: where,
        whereArgs: whereArgs,
      );

      final hasNext = totalItems > safePage * safeLimit;

      return PaginatedResult(
        data: maps,
        metaPagination: MetaPagination(
          page: safePage,
          limit: safeLimit,
          totalItems: totalItems,
          hasNext: hasNext,
        ),
      );
    } catch (e, st) {
      AppLogger.error('Failed to paginate $tableName', e, st);
      rethrow;
    }
  }
}
