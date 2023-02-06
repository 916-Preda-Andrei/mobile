import 'dart:convert';
import 'dart:developer';
import 'ItemModel.dart';
import 'package:http/http.dart' as http;

class ItemsServer {
  static Future<void> insertItem(Item item) async {
    await http.post(
      Uri.parse('http://192.168.43.182:3001/games'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(item.toJson()),
    );
  }

  static Future<List<Item>> getItems() async {
    final response =
        await http.get(Uri.parse('http://192.168.43.182:3001/games'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      // for some ever fucking reason, putting those in the same line makes flutter forget the return type of the streams
      List decodedResponse = json.decode(response.body);
      List<Item> items =
          decodedResponse.map((item) => Item.fromJson(item)).toList();

      return items;
    } else {
      throw Exception('Failed to load items');
    }
  }

  static Future<void> updateItem(Item item) async {
    await http.put(
      Uri.parse('http://192.168.43.182:3001/games/${item.gameId}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(item.toJson()),
    );
  }

  static Future<http.Response> deleteItem(int id) async {
    return await http.delete(
      Uri.parse('http://192.168.43.182:3001/games/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
