import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
        ordering INTEGER NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE rules (
        id TEXT PRIMARY KEY,
        categoryId TEXT NOT NULL,
        title TEXT NOT NULL,
        symbol TEXT,
        detailMd TEXT,
        audioUrl TEXT,
        FOREIGN KEY (categoryId) REFERENCES categories (id)
      );
    ''');

    // === SEED DATA ===

    // Categories
    await db.insert('categories', {
      'id': 'cat1',
      'title': 'HUKUM NUN SUKUN DAN TANWIN',
      'ordering': 1,
    });

    await db.insert('categories', {
      'id': 'cat2',
      'title': 'HUKUM MIM SUKUN',
      'ordering': 2,
    });

    await db.insert('rules', {
      'id': 'r1',
      'categoryId': 'cat1',
      'title': 'Idghom Bighunnah',
      'symbol': 'نْ + ي / ن / م / و',
      'detailMd': '''
### Idghom Bighunnah
Idghom bighunnah terjadi bila nun sukun atau tanwin bertemu dengan huruf **ي، ن، م، و**.  
Contoh: **مَن يَقُولُ**, **سَمِيعٌ مَّبِينٌ**.
''',
    });

    await db.insert('rules', {
      'id': 'r2',
      'categoryId': 'cat1',
      'title': 'Idghom Bilaghunnah',
      'symbol': 'نْ + ر / ل',
      'detailMd': '''
### Idghom Bilaghunnah
Idghom bilaghunnah terjadi bila nun sukun atau tanwin bertemu dengan huruf **ر** atau **ل**.  
Contoh: **غَفُورٌ رَّحِيمٌ**, **مِن لَّدُنْهُ**.
''',
    });

    await db.insert('rules', {
      'id': 'r3',
      'categoryId': 'cat1',
      'title': 'Iqlab',
      'symbol': 'نْ + ب',
      'detailMd': '''
### Iqlab
Iqlab terjadi bila nun sukun atau tanwin bertemu dengan huruf **ب**, dibaca **m** disertai dengung.  
Contoh: **سَمِيعٌ بَصِيرٌ**.
''',
    });

    // Rules for BAB II
    await db.insert('rules', {
      'id': 'r4',
      'categoryId': 'cat2',
      'title': 'Idhar Syafawi',
      'symbol': 'مْ + Huruf selain م dan ب',
      'detailMd': '''
### Idhar Syafawi
Terjadi bila **mim sukun** bertemu huruf selain **م** dan **ب**.
''',
    });

    await db.insert('rules', {
      'id': 'r5',
      'categoryId': 'cat2',
      'title': 'Ikhfa Syafawi',
      'symbol': 'مْ + ب',
      'detailMd': '''
### Ikhfa Syafawi
Terjadi bila **mim sukun** bertemu huruf **ب**.  
Dibaca samar dengan dengung.
''',
    });

    await db.insert('rules', {
      'id': 'r6',
      'categoryId': 'cat2',
      'title': 'Idghom Mimi',
      'symbol': 'مْ + م',
      'detailMd': '''
### Idghom Mimi
Terjadi bila **mim sukun** bertemu huruf **م**.  
Dibaca dengung dan menyatu.
''',
    });
  }
}
