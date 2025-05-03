const standingService = require('../services/standing_service');

exports.getLeagueStandings = async (req, res) => {
    try {
        const { leagueId } = req.params;
        const parsedId = parseInt(leagueId, 10);

        if(isNaN(parsedId)){
            return res.status(400).json({ error: 'Invalid ID format'});
        }

        const standings = await standingService.getLeagueStandings(parsedId);
        return res.status(200).json(standings);
    } catch (error) {
        return res.status(404).json({ error: error.message });        
    }
};

exports.createStanding = async (req, res) => {
    try {
        const standing = await standingService.createStanding(req.body);
        return res.status(201).json(standing);
    } catch (error) {
        return res.status(400).json({ error: error.message });        
    }
};