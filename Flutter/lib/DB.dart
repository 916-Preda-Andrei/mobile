import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'ItemModel.dart';

class ItemsDatabase {
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

  // insert Item
  static Future<void> insertItem(Item item) async {
    final Database db = await open();
    await db.insert(
      'games',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Item>> getItems() async {
    final Database db = await open();
    final List<Map<String, dynamic>> maps = await db.query('games');
    return List.generate(maps.length, (i) {
      return Item(
        gameId: maps[i]['gameId'],
        name: maps[i]['name'],
        section: maps[i]['section'],
        recommendedAge: maps[i]['recommendedAge'],
        numberOfPlayers: maps[i]['numberOfPlayers'],
        availableStock: maps[i]['availableStock'],
      );
    });
  }

  static Future<void> updateItem(Item item) async {
    final db = await open();
    await db.update(
      'games',
      item.toMap(),
      where: "gameId = ?",
      whereArgs: [item.gameId],
    );
  }

  static Future<void> deleteItem(int id) async {
    final db = await open();
    await db.delete(
      'games',
      where: "gameId = ?",
      whereArgs: [id],
    );
  }
}
