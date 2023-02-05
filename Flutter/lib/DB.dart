import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'GameModel.dart';

class GamesDatabase {
  static int database_version = 1;
  static String database_name = 'games.db';

  // open database
  static Future<Database> open() async {
    return openDatabase(
      join(await getDatabasesPath(), database_name),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE games(gameId INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, section TEXT, recommendedAge TEXT, numberOfPlayers TEXT, availableStock INTEGER)",
        );
      },
      version: database_version,
    );
  }

  // insert game
  static Future<void> insertGame(Game game) async {
    final Database db = await open();
    await db.insert(
      'games',
      game.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Game>> getGames() async {
    final Database db = await open();
    final List<Map<String, dynamic>> maps = await db.query('games');
    return List.generate(maps.length, (i) {
      return Game(
        gameId: maps[i]['gameId'],
        name: maps[i]['name'],
        section: maps[i]['section'],
        recommendedAge: maps[i]['recommendedAge'],
        numberOfPlayers: maps[i]['numberOfPlayers'],
        availableStock: maps[i]['availableStock'],
      );
    });
  }

  static Future<void> updateGame(Game game) async {
    final db = await open();
    await db.update(
      'games',
      game.toMap(),
      where: "gameId = ?",
      whereArgs: [game.gameId],
    );
  }

  static Future<void> deleteGame(int id) async {
    final db = await open();
    await db.delete(
      'games',
      where: "gameId = ?",
      whereArgs: [id],
    );
  }
}
