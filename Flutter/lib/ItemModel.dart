class Item {
  int id;
  String name;
  String description;
  String image;
  String category;
  int units;
  double price;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.units,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      category: json['category'],
      units: json['units'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'units': units,
      'price': price,
    };
  }

  toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'units': units,
      'price': price,
    };
  }

  @override
  toString() {
    return 'Item{id: $id, name: $name, description: $description, image: $image, category: $category, units: ${units.toString()}, price: ${price.toString()}';
  }
}
