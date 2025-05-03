const setRepository = require('../db/repositories/set_repo');

class SetService {
    async getMatchSets(matchId) {
        if (!matchId || typeof matchId !== 'number') {
            throw new Error('Invalid team ID'); 
        }

        const sets = await setRepository.getMatchSets(matchId);

        if (sets.length === 0) {
            throw new Error('Match not found or has no sets');
        }
        return sets;
    }

    async createSet(data) {
        
        //TODO

    }
}