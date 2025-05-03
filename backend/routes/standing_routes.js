const express = require('express');
const router = express.Router();
const standingController = require('../controllers/standing_controller');

router.post('/createStanding', standingController.createStanding);

router.get('/leagues/:leagueId/standings', standingController.getLeagueStandings);

module.exports = router;