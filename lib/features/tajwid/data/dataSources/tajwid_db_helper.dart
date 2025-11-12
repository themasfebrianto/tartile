import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tartile/features/tajwid/data/dataSources/Seed/tajwid_categories_seed.dart';
import 'package:tartile/features/tajwid/data/dataSources/Seed/tajwid_idghom_type_seed.dart';
import 'package:tartile/features/tajwid/data/dataSources/Seed/tajwid_lam_taarif_seed.dart';
import 'package:tartile/features/tajwid/data/dataSources/Seed/tajwid_mim_nun_tasydid_seed.dart';
import 'package:tartile/features/tajwid/data/dataSources/Seed/tajwid_mim_sukun_seed.dart';
import 'package:tartile/features/tajwid/data/dataSources/Seed/tajwid_nun_sukun_tanwin_seed.dart';
import 'package:tartile/features/tajwid/data/dataSources/Seed/tajwid_tafkhim_tarkik_seed.dart';

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

    // await deleteDatabase(path); // uncomment kalau mau reset data

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

    // === SEED DATA (FAST BATCH INSERT) ===
    final batch = db.batch();

    // Categories
    for (var category in tajwidCategoriesSeed) {
      batch.insert('categories', category.toMap());
    }

    // Rules
    final allRules = [
      ...tajwidNunSukunTanwinSeed,
      ...tajwidIdghamTypesSeed,
      ...tajwidLamTaarifSeed,
      ...tajwidMimNunTasydidSeed,
      ...tajwidMimSukunSeed,
      ...tajwidTafkhimTarqiqSeed,
    ];

    for (var rule in allRules) {
      batch.insert('rules', rule.toMap());
    }

    await batch.commit(noResult: true);
  }
}
