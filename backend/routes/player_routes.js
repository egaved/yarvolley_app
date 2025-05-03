const express = require('express');
const router = express.Router();
const playerController = require('../controllers/player_controller');

router.post('/createPlayer', playerController.createPlayer);

router.get('/teams/:teamId/players', playerController.getPlayersByTeamId);

module.exports = router;