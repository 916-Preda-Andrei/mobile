import 'dart:developer';

import 'package:flutter/material.dart';

import 'AddItem.dart';
import 'ItemModel.dart';
import 'UpdateItem.dart';
import 'ItemsList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Items List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Items List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();

  Future<List<Item>> itemsList = ItemsList.getItems();

  itemListView() => Expanded(
      child: Card(
          margin: const EdgeInsets.all(10),
          child: FutureBuilder<List<Item>>(
              future: itemsList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Item item = snapshot.data![index];

                        return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Name: ${item.name}'),
                                      Text('Section: ${item.section}'),
                                      Text(
                                          'Recommended Age: ${item.recommendedAge}'),
                                      Text(
                                          'Number Of Players: ${item.numberOfPlayers}'),
                                      Text(
                                          'Available Stock: ${item.availableStock.toString()}'),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () =>
                                            deleteItem(item.gameId),
                                        color: Colors.red,
                                        icon: const Icon(Icons.delete)),
                                    IconButton(
                                        onPressed: () => editItem(item),
                                        icon: const Icon(Icons.edit)),
                                  ],
                                )
                              ],
                            ));
                      });
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                return const CircularProgressIndicator();
              })));

  deleteItem(itemId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Item"),
            content: const Text("Are you sure you want to delete this item?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey),
                  )),
              TextButton(
                  onPressed: () async {
                    try {
                      await ItemsList.deleteItem(itemId);
                    } catch (e) {
                      // showDialog
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Error"),
                              content: Text(e.toString()),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(color: Colors.grey),
                                    )),
                              ],
                            );
                          });
                    }
                    setState(() {
                      itemsList = ItemsList.getItems();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          );
        });
  }

  editItem(item) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UpdateItemPage(item: item);
    })).then((value) async {
      try {
        await ItemsList.updateItem(Item(
            name: value.name,
            section: value.section,
            recommendedAge: value.recommendedAge,
            numberOfPlayers: value.numberOfPlayers,
            availableStock: value.availableStock,
            gameId: item.ItemId));
      } catch (e) {
        // showDialog
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.grey),
                      )),
                ],
              );
            });
      }

      return setState(() {
        itemsList = ItemsList.getItems();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            itemListView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddItemPage();
          })).then((value) async {
            try {
              await ItemsList.insertItem(Item(
                  name: value.name,
                  section: value.section,
                  recommendedAge: value.recommendedAge,
                  numberOfPlayers: value.numberOfPlayers,
                  availableStock: value.availableStock,
                  gameId: -1));
            } catch (e) {
              // showDialog
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Error"),
                      content: Text(e.toString()),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              "OK",
                              style: TextStyle(color: Colors.grey),
                            )),
                      ],
                    );
                  });
            }

            return setState(() {
              itemsList = ItemsList.getItems();
            });
          });
        },
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
