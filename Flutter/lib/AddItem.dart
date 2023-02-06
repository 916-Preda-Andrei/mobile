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
      id: -1,
      name: '',
      description: '',
      image: '',
      category: '',
      units: 0,
      price: 0.0,
  );

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
                labelText: 'Item Description',
              ),
              onSaved: (value) => setState(() => item.description = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a non-empty item description';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Image',
              ),
              onSaved: (value) => setState(() => item.image = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a non-empty Image';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              onSaved: (value) => setState(() => item.category = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a non-empty category';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Units',
              ),
              onSaved: (value) => setState(() {
                item.units = int.tryParse(value!)!;
              }),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    int.tryParse(value) == null ||
                    int.tryParse(value)! < 0) {
                  return 'Please enter a valid units';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              onSaved: (value) => setState(() {
                item.price = double.tryParse(value!)!;
              }),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    double.tryParse(value) == null ||
                    double.tryParse(value)! < 0.0) {
                  return 'Please enter a valid price';
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
