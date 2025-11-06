import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tartile/features/tajwid/data/dataSources/Seed/tajwid_categories_seed.dart';
import 'package:tartile/features/tajwid/data/dataSources/Seed/tajwid_nun_sukun_tanwin_seed.dart';

class TajwidDbHelper {
  static final TajwidDbHelper _instance = TajwidDbHelper._internal();
  factory TajwidDbHelper() => _instance;
  TajwidDbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tajwid.db');
    await deleteDatabase(join(await getDatabasesPath(), 'tajwid.db'));
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // === CREATE TABLES ===
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        icon TEXT NOT NULL,
        ordering INTEGER NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE rules (
        id TEXT PRIMARY KEY,
        categoryId TEXT NOT NULL,
        title TEXT NOT NULL,
        explanation TEXT,
        letters TEXT,
        examples TEXT,
        FOREIGN KEY (categoryId) REFERENCES categories (id)
      );
    ''');

    // === SEED DATA ===

    for (var category in tajwidCategoriesSeed) {
      await db.insert('categories', category.toMap());
    }

    for (var rule in tajwidNunSukunTanwinSeed) {
      await db.insert('rules', rule.toMap());
    }
  }
}
