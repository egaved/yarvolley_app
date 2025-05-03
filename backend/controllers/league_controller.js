const leagueService = require('../services/league_service');

exports.getAllLeagues = async (req, res) => {
    try {
        const leagues = await leagueService.getAllLeagues();
        return res.status(200).json(leagues);
    } catch (err) {
        return res.status(500).json({ error: err.message });
    }
};

exports.getLeagueById = async (req, res) => {
    try {
        const { leagueId } = req.params;
        const parsedId = parseInt(leagueId, 10);

        if (isNaN(parsedId)) {
            return res.status(400).json({ error: 'Invalid ID format'});
        }

        const league = await leagueService.getLeagueById(parsedId);
        return res.status(200).json(league);
    } catch (err) {
        return res.status(400).json({ error: err.message });
    }
};

exports.createLeague = async (req, res) => {
    try {
        const league = await leagueService.createLeague(req.body);
        return res.status(201).json(league);
    } catch (err) {
        return res.status(400).json({ error: err.message });
    }
};