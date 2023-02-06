import 'dart:developer';

import 'package:flutter_app/API.dart';
import 'ItemModel.dart';
import "DB.dart";
// exceptions are forwarded to be catched by the flutter component which displays alert

class ItemsList {
  static Future<List<Item>> getItems() async {
    return ItemsServer.getItems();
  }

  static Future<void> insertItem(Item item) async {
    try {
      await ItemsServer.insertItem(item);
      log("inserted item: $item");
    } catch (e) {
      log("error inserting item: $e");
      throw e;
    }
  }

  static Future<void> updateItem(Item item) async {
    try {
      await ItemsServer.updateItem(item);
      log("updated item: $item");
    } catch (e) {
      log("error updating item: $e");
      throw e;
    }
  }

  static Future<void> deleteItem(int itemId) async {
    try {
      await ItemsServer.deleteItem(itemId);
      log("deleted item: $itemId");
    } catch (e) {
      log("error deleting item: $e");
      throw e;
    }
  }
}
