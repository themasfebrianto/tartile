import 'tajwid_db_helper.dart';
import '../models/tajwid_rule.dart';

class TajwidRulesDataSource {
  final TajwidDbHelper dbHelper = TajwidDbHelper();

  /// Ambil semua aturan tajwid
  Future<List<TajwidRuleModel>> getAllRules() async {
    final db = await dbHelper.database;
    final maps = await db.query('rules', orderBy: 'title ASC');
    return maps.map((e) => TajwidRuleModel.fromMap(e)).toList();
  }

  /// Tambahkan aturan baru
  Future<void> addRule(TajwidRuleModel rule) async {
    final db = await dbHelper.database;
    await db.insert('rules', rule.toMap());
  }

  /// Cari aturan tajwid berdasarkan kata kunci
  Future<List<TajwidRuleModel>> searchRules(String query) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'rules',
      where: 'title LIKE ? OR detailMd LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'title ASC',
    );
    return maps.map((e) => TajwidRuleModel.fromMap(e)).toList();
  }

  /// Ambil aturan tajwid berdasarkan kategori
  Future<List<TajwidRuleModel>> getRulesByCategory(String categoryId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'rules',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
      orderBy: 'title ASC',
    );
    return maps.map((e) => TajwidRuleModel.fromMap(e)).toList();
  }
}
