const teamRepository = require('../db/repositories/team_repo.js');

class TeamService {
  async getTeamsByLeagueId(leagueId) {
    if (!leagueId || typeof leagueId !== 'number') {
      throw new Error('Invalid league ID'); 
    }

    const teams = await teamRepository.getTeamsByLeagueId(leagueId);

    if (teams.length === 0) {
      throw new Error('League not found or has no teams');
    }
    return teams;
  }

  async getTeamsNames(teamIds) {
    if (!Array.isArray(teamIds) || !teamIds.every(id => typeof id === 'number')) {
      throw new Error('Invalid team IDs');
    }
    const teams = await teamRepository.getTeamsNames(teamIds);

    const foundIds = teams.map(team => team.id);
    const missingIds = teamIds.filter(id => !foundIds.includes(id));
    
    if (missingIds.length > 0) {
      console.warn(`Teams not found for IDs: ${missingIds}`);
    }

    return teams;
  }

  async getTeamById(teamId) {
    if (!teamId || typeof teamId !== 'number') {
      throw new Error('Invalid team ID'); 
    }
    const team = await teamRepository.getTeamById(teamId);
    if (team === null) {
      throw new Error('team not found');
    }
    return team;
  }

  // Создать команду с валидацией
  async createTeam(data) {
    if (!data.name || !data.league_id) {
      throw new Error('Missing required fields');
    }
    const teamId = await teamRepository.createTeam(data);
    return { id: teamId };
  }
}

module.exports = new TeamService();