import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tartile/core/constants/database_settings.dart';
import 'package:tartile/core/utils/common/app_logger.dart';

/// Signature untuk fungsi pembuat tabel.
typedef TableCreator = Future<void> Function(Database db, int version);

/// SQLiteDbContext berfungsi sebagai konteks utama database SQLite.
class SQLiteDbContext {
  static Database? _database;
  static String get dbName => DatabaseSettings.dbName;
  static int get dbVersion => DatabaseSettings.dbVersion;

  /// Menyimpan daftar fungsi pembuat tabel dari tiap fitur (modular).
  static final List<TableCreator> _tableCreators = [];

  /// Register fungsi pembuatan tabel dari fitur (dipanggil di konstruktor LocalDataSource).
  static void registerTable(TableCreator creator) {
    _tableCreators.add(creator);
  }

  /// Mengembalikan instance database yang sudah diinisialisasi.
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Inisialisasi dan buka koneksi database.
  static Future<Database> _initDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, dbName);

      return await openDatabase(
        path,
        version: dbVersion,
        onCreate: (db, version) async {
          for (final creator in _tableCreators) {
            await creator(db, version);
          }
        },
      );
    } catch (e, st) {
      AppLogger.error('Failed to initialize SQLite database', e, st);
      rethrow;
    }
  }

  /// Hapus seluruh tabel dan data di database (untuk kebutuhan debug/testing).
  static Future<void> clearAllTables() async {
    try {
      final db = await database;
      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
      );

      for (final table in tables) {
        final tableName = table['name'] as String;
        await db.delete(tableName);
      }
      AppLogger.info('All tables cleared.');
    } catch (e, st) {
      AppLogger.error('Failed to clear all tables', e, st);
      rethrow;
    }
  }

  /// Tutup koneksi database secara manual (jarang diperlukan).
  static Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      AppLogger.info('SQLite database closed.');
    }
  }
}
