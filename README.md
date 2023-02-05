To Run the project

Have installed - PostgreSQL, node ( +npm/yarn), any manner of running Flutter 

in Server/ db.sql you have a DB for a config. Create the DB and the table. 

There you also have some test data. Feel free to Copy Paste them into PostgreSQL console. 

Inside the Server folder, create an `.env` file which will contain 
```
PG_USER=postgres
PG_PASSWORD=not-sharing-my-passowrd
PG_HOST=localhost
PG_PORT=5432
PG_DATABASE=games_list
```

Feel free to replace PG_USER, PG_PASSWORD and PG_DATABASE with your values.

Now, you can `npm i`/ `yarn install`

After the install is done, run the server either by `yarn start`, `npm run start` or even `node server.js`

You will have a CRUD server connected to a postgres DB running on port `3001`. 

You can now open and build the Flutter app in your favourite IDE and it should work out of the box.





