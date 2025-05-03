const express = require('express');
const router = express.Router();
const leagueController = require('../controllers/league_controller');

router.get('/leagues', leagueController.getAllLeagues);

router.get('/leagues/:leagueId', leagueController.getLeagueById);

router.post('/createLeague', leagueController.createLeague);

module.exports = router;