import 'package:flutter/material.dart';

import 'GameModel.dart';

class UpdateGamePage extends StatefulWidget {
  Game game;
  UpdateGamePage({super.key, required this.game});

  @override
  UpdateGameState createState() => UpdateGameState(game);
}

class UpdateGameState extends State<UpdateGamePage> {
  final formKey = GlobalKey<FormState>();
  Game game = Game(
      gameId: -1,
      name: '',
      section: '',
      recommendedAge: '',
      numberOfPlayers: '',
      availableStock: 0);

  UpdateGameState(Game _game) {
    game = _game;
  }

  _form() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Game Name',
              ),
              initialValue: game.name,
              onSaved: (value) => setState(() => game.name = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a non-empty name';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Game Section',
              ),
              initialValue: game.section,
              onSaved: (value) => setState(() => game.section = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a non-empty game section';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Recommended Age',
              ),
              initialValue: game.recommendedAge,
              onSaved: (value) => setState(() => game.recommendedAge = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a non-empty Recommended Age';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Number of Players',
              ),
              initialValue: game.numberOfPlayers,
              onSaved: (value) => setState(() => game.numberOfPlayers = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a non-empty number of players';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Available Stock',
              ),
              initialValue: game.availableStock.toString(),
              onSaved: (value) => setState(() {
                game.availableStock = int.tryParse(value!)!;
              }),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    int.tryParse(value) == null ||
                    int.tryParse(value)! < 0) {
                  return 'Please enter a valid available stock';
                }
                return null;
              },
            ),
            Container(
                width: 200,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Navigator.pop(context, game);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Update Game'),
                    ))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Game'),
      ),
      body: _form(),
    );
  }
}
