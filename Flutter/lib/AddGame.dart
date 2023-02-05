import 'package:flutter/material.dart';

import 'GameModel.dart';

class AddGamePage extends StatefulWidget {
  const AddGamePage({super.key});

  @override
  AddGameState createState() => AddGameState();
}

class AddGameState extends State<AddGamePage> {
  final formKey = GlobalKey<FormState>();
  Game game = Game(
      gameId: -1,
      name: '',
      section: '',
      recommendedAge: '',
      numberOfPlayers: '',
      availableStock: 0);

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
                    // style: ButtonStyle(padding:)
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Navigator.pop(context, game);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Add Game'),
                    )))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Game'),
      ),
      body: _form(),
    );
  }
}
