const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

app.use(cors()); // Для обработки CORS 
app.use(bodyParser.json()); // Для парсинга JSON 

const teamRoutes = require('./routes/team_routes');
const playerRoutes = require('./routes/player_routes');
const leagueRoutes = require('./routes/league_routes');
const matchRoutes = require('./routes/match_routes');
const standingRoutes = require('./routes/standing_routes');

app.use('/api', teamRoutes);
app.use('/api', playerRoutes);
app.use('/api', leagueRoutes);
app.use('/api', matchRoutes);
app.use('/api', standingRoutes);

// Обработка ошибок (пример)
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Что-то пошло не так!' });
});

module.exports = app;