const playerRepository = require('../db/repositories/player_repo');

class PlayerService {

    async createPlayer(data) {
        if (!data.name || !data.team_id) {
            throw new Error ('Missing required fields');
        }
        const playerId = await playerRepository.createPlayer(data);
        return {id: playerId};
    } 

    async getPlayersByTeamId(teamId) {
        if (!teamId || typeof teamId !== 'number') {
            throw new Error('Invalid team ID'); 
        }

        const players = await playerRepository.getPlayersByTeamId(teamId);

        if (players.length === 0) {
            throw new Error('Team not found or has no players');
        }
        return players;
    }
}

module.exports = new PlayerService();
