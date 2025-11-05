import 'tajwid_db_helper.dart';

class TajwidCategoryDataSource {
  final TajwidDbHelper dbHelper = TajwidDbHelper();

  /// Ambil semua kategori tajwid
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    final db = await dbHelper.database;
    final maps = await db.query('categories', orderBy: 'ordering ASC');
    return maps;
  }
}
