const express = require("express");
const app = express();
const { pool } = require("./database");

const logWritter = require("./logWritter");
const cors = require("cors");
app.use(cors());
app.use(express.json());
app.set("port", process.env.PORT || 3001);
//app.set("trust proxy", true);
const converter = require("./utils").converter;

app.get("/games", async (req, res) => {
  try {
    const games = await pool.query("SELECT * FROM games ORDER BY game_id");
    if (games.rows.length === 0) {
      logWritter("No games were found");
      return res.status(404).send("No games were found");
    }

    logWritter("All games were requested");

    res.json(converter(games.rows));
  } catch (err) {
    logWritter(`${err.message} on GET /games`);
    console.error(err.message);
  }
});

app.get("/games/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const game = await pool.query("SELECT * FROM games WHERE game_id = $1", [
      id,
    ]);
    if (game.rows.length === 0) {
      logWritter(`Game with id ${id} was not found`);
      return res.status(404).send("Game not found");
    }

    logWritter(`Game with id ${id} was requested`);
    res.json(game.rows[0]);
  } catch (err) {
    logWritter(`${err.message} on GET /games/:id`);
    res.status(500).send("Server Error");
  }
});

app.post("/games", async (req, res) => {
  try {
    const { name, section, recommendedAge, numberOfPlayers, availableStock } =
      req.body;
    const newGame = await pool.query(
      "INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES($1, $2, $3, $4, $5) RETURNING *",
      [name, section, recommendedAge, numberOfPlayers, availableStock]
    );
    if (newGame.rows.length === 0) {
      logWritter("Bad Request on POST /games");
      return res.status(400).send("Bad Request");
    }

    logWritter(`Created game with id ${newGame.rows[0].game_id} was created`);

    res.json(newGame.rows[0]);
  } catch (err) {
    logWritter(`${err.message} on POST /games`);

    res.status(500).send("Server Error");
  }
});

app.put("/games/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { name, section, recommendedAge, numberOfPlayers, availableStock } =
      req.body;
    if (
      !name ||
      !section ||
      !recommendedAge ||
      !numberOfPlayers ||
      isNaN(availableStock)
    ) {
      logWritter("Bad Request on PUT /games/:id");
      return res.status(400).send("Bad Request");
    }

    const updateGame = await pool.query(
      "UPDATE games SET name = $1, section = $2, recommended_age = $3, number_of_players = $4, available_stock = $5 WHERE game_id = $6",
      [name, section, recommendedAge, numberOfPlayers, availableStock, id]
    );
    if (updateGame.rows.length === 0) {
      logWritter("Bad Request on PUT /games/:id");
      return res.status(400).send("Bad Request");
    }

    logWritter(`Game with id ${id} was updated`);

    res.json("Game was updated!");
  } catch (err) {
    logWritter(`${err.message} on PUT /games/:id`);
    console.error(err.message);
  }
});

// DELETE /games/:id
app.delete("/games/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const deleteGame = await pool.query(
      "DELETE FROM games WHERE game_id = $1",
      [id]
    );

    if (deleteGame.rows.length === 0) {
      logWritter("Bad Request on DELETE /games/:id");
      return res.status(400).send("Bad Request");
    }

    logWritter(`Game with id ${id} was deleted`);
    res.json("Game was deleted!");
  } catch (err) {
    logWritter(`${err.message} on DELETE /games/:id`);
    console.error(err.message);
  }
});

app.get("*", async (req, res) => {
  res.status(404).send("404 Not Found");
});

logWritter("Server started");
// Starting server
// exit codes
// 200 - OK
// 201 - Created
// 400 - Bad Request
// 401 - Unauthorized
// 403 - Forbidden
// 500 - Internal Server Error

app.listen(app.get("port"), function () {
  console.log(`Starting server on port ${app.get("port")}`);
});
