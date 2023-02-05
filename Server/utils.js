const nameMapper = {
  game_id: "gameId",
  name: "name",
  section: "section",
  recommended_age: "recommendedAge",
  number_of_players: "numberOfPlayers",
  available_stock: "availableStock",
};

function converter(listOfItems) {
  return listOfItems.map((item) => {
    const newItem = {};
    for (const key in item) {
      const newKey = nameMapper[key];
      newItem[newKey] = item[key];
    }
    return newItem;
  });
}

module.exports = { converter };
