import 'package:tartile/core/utils/base/paginated_response_base.dart';
import 'package:tartile/core/utils/common/sqlite_db_context.dart';
import 'package:tartile/core/utils/common/sqlite_table.dart';
import 'package:tartile/features/module/data/dtos/category/category_filter_dto.dart';
import 'package:tartile/features/module/data/mappers/category_mapper.dart';
import '../../domain/entities/category_entity.dart';
import 'package:tartile/core/constants/database_settings.dart';
import 'package:sqflite/sqflite.dart';

class CategoryLocalDataSource {
  static const _tableName = DatabaseSettings.tableCategories;

  final SQLiteTable _table;

  CategoryLocalDataSource() : _table = SQLiteTable(_tableName) {
    SQLiteDbContext.registerTable(_onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        courseId TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        icon TEXT,
        ordering INTEGER NOT NULL,
        isLocked INTEGER NOT NULL DEFAULT 0,
        requiredLevel INTEGER,
        createdAt TEXT NOT NULL,
        updatedAt TEXT
      )
    ''');
  }

  // ----------------------------------------------------------
  // CRUD OPERATIONS
  // ----------------------------------------------------------

  Future<void> insertCategory(CategoryEntity category) async {
    await _table.insert(CategoryMapper.toMap(category));
  }

  Future<void> insertCategories(List<CategoryEntity> categories) async {
    for (final category in categories) {
      await _table.insert(CategoryMapper.toMap(category));
    }
  }

  Future<List<CategoryEntity>> getAllCategories(
    CategoryFilterDto filter,
  ) async {
    final maps = await _table.findAll(orderBy: filter.sortBy ?? 'ordering ASC');
    return maps
        .map((e) => CategoryMapper.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<PaginatedResult<CategoryEntity>> getAllCategoriesPaginated(
    CategoryFilterDto filter,
  ) async {
    final result = await _table.findPaginated(
      page: filter.page ?? 1,
      limit: filter.limit ?? 10,
      orderBy: filter.sortBy ?? 'ordering ASC',
    );

    final data = result.data
        .map((e) => CategoryMapper.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    return PaginatedResult(data: data, metaPagination: result.metaPagination);
  }

  Future<CategoryEntity?> getCategoryById(String id) async {
    final map = await _table.findOne(where: 'id = ?', whereArgs: [id]);
    if (map == null) return null;
    return CategoryMapper.fromMap(Map<String, dynamic>.from(map));
  }

  Future<int> updateCategory(CategoryEntity category) async {
    return await _table.update(
      CategoryMapper.toMap(category),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> deleteCategory(String id) async {
    return await _table.delete(where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCategories() async {
    await _table.clear();
  }
}
