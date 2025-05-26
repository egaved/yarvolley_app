const pool = require('../../config/connection.js');

class MatchRepository {
    async getLeagueMatches(leagueId) {
        const [rows] = await pool.query(`
              SELECT * FROM \`Match\`
              WHERE league_id = ?
            `, [leagueId]);
        return rows;
    }

    async getMatchById(matchId) {
        const [rows] = await pool.query(`
            SELECT * FROM \`Match\`
            WHERE id = ?
          `, [matchId]);
        return rows;
    }

    async getTeamMatches(teamId) {
        const [rows] = await pool.query(`
            SELECT * FROM \`Match\` 
            WHERE team1_id = ? OR team2_id = ?
            ORDER BY date ASC
        `, [teamId, teamId]);
        return rows;
    }

    async createMatch (data) {
        const {
            date,
            location,
            is_upcoming,
            team1_id,
            team2_id,
            league_id,
            team1_total_score,
            team2_total_score,
            winner_team_id
        } = data;
        const [result] = await pool.query(`
            INSERT INTO 
            \`Match\` (id, date, location, is_upcoming, team1_id, team2_id,
             league_id, team1_total_score, team2_total_score, winner_team_id)
             VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?)  
        `, [date, location, is_upcoming, team1_id, team2_id, league_id, team1_total_score, team2_total_score, winner_team_id]);
        return result.insertId;
    }
}

module.exports = new MatchRepository();