const express = require('express');
const router = express.Router();
const matchController = require('../controllers/match_controller');

router.post('/createMatch', matchController.createMatch);

router.get('/leagues/:leagueId/matches', matchController.getLeagueMatches);

router.get('/teams/:teamId/matches', matchController.getTeamMatches);

router.get('/matches/:matchId', matchController.getMatchById);

module.exports = router;
