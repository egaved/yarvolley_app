const matchRepository = require('../db/repositories/match_repo');

const REQUIRED_FIELDS = [
    'date',
    'location',
    'is_upcoming',
    'team1_id',
    'team2_id',
    'league_id',
  ];

class MatchService {
    async getLeagueMatches(leagueId) {
        if (!leagueId || typeof leagueId !== 'number') {
            throw new Error('Invalid league ID'); 
        }

        const matches = await matchRepository.getLeagueMatches(leagueId);

        if (matches.length === 0) {
            throw new Error('League not found or has no matches');
        }

        return matches;
    }

    async getMatchById (matchId) {
        if (!matchId || typeof matchId !== 'number') {
            throw new Error('Invalid match ID'); 
        }
        
        const match = await matchRepository.getMatchById(matchId);
        if (match === null) {
            throw new Error('Match not found');
        }

        return match;
    }

    async getTeamMatches(teamId) {
        if (!teamId || typeof teamId !== 'number') {
            throw new Error('Invalid team ID'); 
        }

        const matches = await matchRepository.getTeamMatches(teamId);

        if (matches.length === 0) {
            throw new Error('Team not found or has no matches');
        }

        return matches;
    }

    async createMatch (data) {
        const missingFields = REQUIRED_FIELDS.filter(field => !(field in data));
        if (missingFields.length > 0) {
            throw new Error(`Missing required fields: ${missingFields.join(', ')}`); // [[2]]
        }

        const matchId = await matchRepository.createMatch(data);
        return { id: matchId };
    }
}

module.exports = new MatchService();