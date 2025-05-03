const standingRepository = require('../db/repositories/standing_repo');

const REQUIRED_FIELDS = [
    'game_amount',
    'wins',
    'losses',
    'position',
    'balance',
    'points',
    'updated_at',
    'league_id',
    'team_id'
  ];

class StandingService {
    async getLeagueStandings(leagueId) {
        if (!leagueId || typeof leagueId !== 'number') {
            throw new Error('Invalid league ID'); 
        }

        const standings = await standingRepository.getLeagueStandings(leagueId);

        if (standings.length === 0) {
            throw new Error('League not found or has no standings. Internal error');
        }
        return standings;
    }

    async createStanding(data) {
        const missingFields = REQUIRED_FIELDS.filter(field => !(field in data));
        if (missingFields.length > 0) {
          throw new Error(`Missing required fields: ${missingFields.join(', ')}`); // [[2]]
        }
      
        const standingId = await standingRepository.createStanding(data);
        return { id: standingId };
    }
}

module.exports = new StandingService();