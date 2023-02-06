import 'package:flutter/material.dart';

import 'ItemModel.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  AddItemState createState() => AddItemState();
}

class AddItemState extends State<AddItemPage> {
  final formKey = GlobalKey<FormState>();
  Item item = Item(
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
                labelText: 'Item Name',
              ),
              onSaved: (value) => setState(() => item.name = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a non-empty name';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Item Section',
              ),
              onSaved: (value) => setState(() => item.section = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a non-empty item section';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Recommended Age',
              ),
              onSaved: (value) => setState(() => item.recommendedAge = value!),
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
              onSaved: (value) => setState(() => item.numberOfPlayers = value!),
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
                item.availableStock = int.tryParse(value!)!;
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
                        Navigator.pop(context, item);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Add Item'),
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
        title: const Text('Add Item'),
      ),
      body: _form(),
    );
  }
}
