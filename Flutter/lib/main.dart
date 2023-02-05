import 'dart:developer';

import 'package:flutter/material.dart';

import 'AddGame.dart';
import 'GameModel.dart';
import 'UpdateGame.dart';
import 'GamesList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Games List'),
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

  Future<List<Game>> gamesList = GamesList.getGames();

  gameListView() => Expanded(
      child: Card(
          margin: const EdgeInsets.all(10),
          child: FutureBuilder<List<Game>>(
              future: gamesList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Game game = snapshot.data![index];

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
                                      Text('Name: ${game.name}'),
                                      Text('Section: ${game.section}'),
                                      Text(
                                          'Recommended Age: ${game.recommendedAge}'),
                                      Text(
                                          'Number Of Players: ${game.numberOfPlayers}'),
                                      Text(
                                          'Available Stock: ${game.availableStock.toString()}'),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () =>
                                            deleteGame(game.gameId),
                                        color: Colors.red,
                                        icon: const Icon(Icons.delete)),
                                    IconButton(
                                        onPressed: () => editGame(game),
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

  deleteGame(gameId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Game"),
            content: const Text("Are you sure you want to delete this game?"),
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
                      await GamesList.deleteGame(gameId);
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
                      gamesList = GamesList.getGames();
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

  editGame(game) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UpdateGamePage(game: game);
    })).then((value) async {
      try {
        await GamesList.updateGame(Game(
            name: value.name,
            section: value.section,
            recommendedAge: value.recommendedAge,
            numberOfPlayers: value.numberOfPlayers,
            availableStock: value.availableStock,
            gameId: game.gameId));
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
        gamesList = GamesList.getGames();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Games List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            gameListView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddGamePage();
          })).then((value) async {
            try {
              await GamesList.insertGame(Game(
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
              gamesList = GamesList.getGames();
            });
          });
        },
        tooltip: 'Add new game',
        child: const Icon(Icons.add),
      ),
    );
  }
}
