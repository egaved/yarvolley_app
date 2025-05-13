const express = require('express');
const router = express.Router();
const teamController = require('../controllers/team_controller');

router.post('/createTeam', teamController.createTeam); 

router.get('/teams/:teamId', teamController.getTeamById);

router.get('/leagues/:leagueId/teams', teamController.getTeamsByLeagueId);

router.get('/teams', teamController.getTeamNamesByIds);

router.get('/favorite_leagues_teams', teamController.getFavoriteLeaguesTeams);

module.exports = router;