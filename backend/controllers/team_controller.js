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

exports.getFavoriteLeaguesTeams = async (req, res) => {
  try {
    const leagueIds = req.query.league_ids;
    if (!leagueIds) {
      return res.status(400).json({ error: 'Параметр league_ids обязателен' });
    }
    const leagueIdList = leagueIds.split(',').map(id => parseInt(id, 10));
    if (leagueIdList.some(isNaN)) {
      return res.status(400).json({ error: 'Некорректные идентификаторы лиг' });
    }
    const data = await teamService.getFavoriteLeaguesTeams(leagueIdList);
    res.json(data);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
}