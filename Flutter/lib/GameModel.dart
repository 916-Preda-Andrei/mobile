class Game {
  int gameId;
  String name;
  String section;
  String recommendedAge;
  String numberOfPlayers;
  int availableStock;

  Game({
    required this.gameId,
    required this.name,
    required this.section,
    required this.recommendedAge,
    required this.numberOfPlayers,
    required this.availableStock,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameId: json['gameId'],
      name: json['name'],
      section: json['section'],
      recommendedAge: json['recommendedAge'],
      numberOfPlayers: json['numberOfPlayers'],
      availableStock: json['availableStock'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'section': section,
      'recommendedAge': recommendedAge,
      'numberOfPlayers': numberOfPlayers,
      'availableStock': availableStock,
    };
  }

  toJson() {
    return {
      'name': name,
      'section': section,
      'recommendedAge': recommendedAge,
      'numberOfPlayers': numberOfPlayers,
      'availableStock': availableStock,
    };
  }

  @override
  toString() {
    return 'Game{gameId: $gameId, name: $name, section: $section, recommendedAge: $recommendedAge, numberOfPlayers: $numberOfPlayers, availableStock: ${availableStock.toString()}';
  }
}
