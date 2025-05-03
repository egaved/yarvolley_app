const playerService = require('../services/player_service');

exports.createPlayer = async (req, res) => {
    try {
        const player = await playerService.createPlayer(req.body);
        res.status(201).json(player);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
};

exports.getPlayersByTeamId = async (req, res) => {
    try {
        const { teamId } = req.params;
        const parsedId = parseInt(teamId, 10);

        if (isNaN(parsedId)) {
            return res.status(400).json({ error: 'Invalid ID format' });
        }

        const players = await playerService.getPlayersByTeamId(parsedId);
        return res.status(200).json(players);
    } catch (error) {
        return res.status(404).json({ error: error.message }); 
    }
};