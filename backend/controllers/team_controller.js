const teamService = require('../services/team_service');

exports.getTeamsByLeagueId = async (req, res) => {
  try {
    const { leagueId } = req.params;
    const parsedId = parseInt(leagueId, 10);

    if (isNaN(parsedId)) {
      return res.status(400).json({ error: 'Invalid ID format' });
    }

    const teams = await teamService.getTeamsByLeagueId(parsedId);
    return res.status(200).json(teams);

  } catch (error) {
    return res.status(404).json({ error: error.message }); 
  }
};

exports.getTeamById = async (req, res) => {
  try {
    const { teamId } = req.params;
    const parsedId = parseInt(teamId, 10);
    if (isNaN(parsedId)) {
      return res.status(400).json({ error: 'Invalid ID format' });
    }
  
    const team = await teamService.getTeamById(parsedId);
    return res.status(200).json(team);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
}

exports.createTeam = async (req, res) => {
  try {
    const team = await teamService.createTeam(req.body);
    return res.status(201).json(team);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};

exports.getTeamNamesByIds = async (req, res) => {
  try {
    const idsParam = req.query.ids;
    if (!idsParam) {
      return res.status(400).json({ error: 'Missing "ids" parameter' });
    }

    const teamIds = idsParam.split(',')
      .map(id => parseInt(id.trim(), 10))
      .filter(id => !isNaN(id));

    if (teamIds.length === 0) {
      return res.status(400).json({ error: 'No valid team IDs provided' });
    }

    const teams = await teamService.getTeamsNames(teamIds);
    return res.status(200).json(teams);

  } catch (error) {
    return res.status(404).json({ error: error.message });
  }
};