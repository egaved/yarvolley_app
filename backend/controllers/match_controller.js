const matchService = require('../services/match_service');

exports.getLeagueMatches = async (req, res) => {
    try {
        const { leagueId } = req.params;
        const parsedId = parseInt(leagueId, 10);

        if (isNaN(parsedId)) {
            return res.status(400).json({ error: 'Invalid ID format' });
        }

        const matches = await matchService.getLeagueMatches(parsedId);
        return res.status(200).json(matches);
    } catch (error) {
        return res.status(404).json({ error: error.message });
    }
};

exports.getMatchById = async (req, res) => {
    try {
        const { matchId } = req.params;
        const parsedId = parseInt(matchId, 10);

        if (isNaN(parsedId)) {
            return res.status(400).json({ error: 'Invalid ID format' });
        }
        
        const match = await matchService.getMatchById(parsedId);
        return res.status(200).json(match);
    } catch (error) {
        return res.status(400).json({ error: error.message });
    }
};

exports.getTeamMatches = async (req, res) => {
    try {
        const { teamId } = req.params;
        const parsedId = parseInt(teamId, 10);

        if (isNaN(parsedId)) {
            return res.status(400).json({ error: 'Invalid ID format' });
        }

        const matches = await matchService.getTeamMatches(parsedId);
        return res.status(200).json(matches);
    } catch (error) {
        return res.status(404).json({ error: error.message });
    }
};

exports.createMatch = async (req, res) => {
    try {
        const match = await matchService.createMatch(req.body);
        return res.status(201).json(match);
    } catch (error) {
        return res.status(400).json({ error: error.message });
    }
};