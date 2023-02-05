-- CREATE DATABASE games_list;
-- \c games_list


CREATE TABLE IF NOT EXISTS games (
  game_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  section VARCHAR(255) NOT NULL,
  recommended_age VARCHAR(255) NOT NULL,
  number_of_players VARCHAR(255) NOT NULL,
  available_stock INT NOT NULL
);


INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('Monopoly', 'Board Games', '8+', '2-8', 10);
INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('Cluedo', 'Board Games', '8+', '3-6', 10);
INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('Catan', 'Board Games', '10+', '3-4', 10);
INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('Pictionary', 'Board Games', '8+', '4-8', 10);
INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('Risk', 'Board Games', '10+', '2-6', 10);
INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('Scrabble', 'Board Games', '8+', '2-4', 10);
INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('Battleship', 'Board Games', '8+', '2', 10);
INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('Uno', 'Card Games', '7+', '2-10', 10);
INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('Go Fish', 'Card Games', '7+', '2-4', 10);
INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('Snap', 'Card Games', '7+', '2-4', 10);
INSERT INTO games (name, section, recommended_age, number_of_players, available_stock) VALUES ('War', 'Card Games', '7+', '2', 10);

-- delete all from table 
-- DELETE FROM games;
 -- connect to postgres linux
  // does not work
  // psql -U postgres -d games_list