const express = require('express');
const router = express.Router();
const teamController = require('../controllers/team_controller');

router.post('/createTeam', teamController.createTeam); 

router.get('/teams/:teamId', teamController.getTeamById);

router.get('/leagues/:leagueId/teams', teamController.getTeamsByLeagueId);

router.get('/teams', teamController.getTeamNamesByIds);

module.exports = router;