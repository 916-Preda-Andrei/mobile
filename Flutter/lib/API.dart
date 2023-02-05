import 'dart:convert';
import 'dart:developer';
import 'GameModel.dart';
import 'package:http/http.dart' as http;

class GamesServer {
  static Future<void> insertGame(Game game) async {
    await http.post(
      Uri.parse('http://localhost:3001/games'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(game.toJson()),
    );
  }

  static Future<List<Game>> getGames() async {
    final response =
        await http.get(Uri.parse('http://localhost:3001/games'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      // for some ever fucking reason, putting those in the same line makes flutter forget the return type of the streams
      List decodedResponse = json.decode(response.body);
      List<Game> games =
          decodedResponse.map((game) => Game.fromJson(game)).toList();

      return games;
    } else {
      throw Exception('Failed to load games');
    }
  }

  static Future<void> updateGame(Game game) async {
    await http.put(
      Uri.parse('http://localhost:3001/games/${game.gameId}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(game.toJson()),
    );
  }

  static Future<http.Response> deleteGame(int id) async {
    return await http.delete(
      Uri.parse('http://localhost:3001/games/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
