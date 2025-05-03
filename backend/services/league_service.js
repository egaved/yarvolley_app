const leagueRepository = require('../db/repositories/league_repo');

class LeagueService {

    async getAllLeagues() {
        return await leagueRepository.getAllLeagues();
    }

    async getLeagueById(leagueId) {
        return await leagueRepository.getLeagueById(leagueId);
    }

    async createLeague(data) {
        if (!data.name || !data.is_active) {
            throw new Error('Missing required fields');
        }
        const leagueId = await leagueRepository.createLeague(data);
        return { id: leagueId };
    }
}

module.exports = new LeagueService();
