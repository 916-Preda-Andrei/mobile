import 'dart:developer';

import 'package:flutter_app/API.dart';
import 'GameModel.dart';
// import "DB.dart";
// exceptions are forwarded to be catched by the flutter component which displays alert

class GamesList {
  static Future<List<Game>> getGames() async {
    return GamesServer.getGames();
  }

  static Future<void> insertGame(Game game) async {
    try {
      await GamesServer.insertGame(game);
      log("inserted game: $game");
    } catch (e) {
      log("error inserting game: $e");
      throw e;
    }
  }

  static Future<void> updateGame(Game game) async {
    try {
      await GamesServer.updateGame(game);
      log("updated game: $game");
    } catch (e) {
      log("error updating game: $e");
      throw e;
    }
  }

  static Future<void> deleteGame(int gameId) async {
    try {
      await GamesServer.deleteGame(gameId);
      log("deleted game: $gameId");
    } catch (e) {
      log("error deleting game: $e");
      throw e;
    }
  }
}
