import 'package:cowlarmovies/models/fav_movie_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'movies.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE movies(
            id INTEGER PRIMARY KEY,
            title TEXT,
            posterPath TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> insertMovie(FavMovie movie) async {
    final db = await database;
    await db.insert(
      'movies',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<FavMovie?> getMovieById(int id) async {
    final db = await database;
    final maps = await db.query(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return FavMovie.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<FavMovie>> getAllMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('movies');

    return List.generate(maps.length, (i) {
      return FavMovie.fromMap(maps[i]);
    });
  }

  Future<void> removeMovie(int id) async {
    final db = await database;
    await db.delete(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
