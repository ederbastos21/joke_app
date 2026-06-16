import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/joke_model.dart';

class JokeLocalSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'jokes.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            category TEXT NOT NULL,
            type TEXT NOT NULL,
            setup TEXT,
            delivery TEXT,
            joke TEXT,
            safe INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> saveFavorite(JokeModel joke) async {
    final db = await database;
    await db.insert(
      'favorites',
      {
        'id': joke.id,
        'category': joke.category,
        'type': joke.type,
        'setup': joke.setup,
        'delivery': joke.delivery,
        'joke': joke.joke,
        'safe': joke.safe ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<JokeModel>> getFavorites() async {
    final db = await database;
    final rows = await db.query('favorites');

    return rows.map((row) {
      return JokeModel(
        id: row['id'] as int,
        category: row['category'] as String,
        type: row['type'] as String,
        setup: row['setup'] as String?,
        delivery: row['delivery'] as String?,
        joke: row['joke'] as String?,
        safe: (row['safe'] as int) == 1,
      );
    }).toList();
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final rows = await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return rows.isNotEmpty;
  }
}
