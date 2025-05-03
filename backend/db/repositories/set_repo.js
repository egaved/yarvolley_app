const pool = require('../../config/connection.js');

class SetRepository {
    async getMatchSets(matchId) {
        const [rows] = await pool.query(`
            SELECT * FROM Set
            WHERE match_id = ? 
        `, [matchId]);
        return rows;
    }

    async createSet(data) {
        const { match_id, set_number, team1_score, team2_score, winner_team_id } = data;
        const [result] = await pool.query(`
          INSERT INTO \`Set\` 
          (match_id, set_number, team1_score, team2_score, winner_team_id) 
          VALUES (?, ?, ?, ?, ?)
        `, [match_id, set_number, team1_score, team2_score, winner_team_id]);
        return result.insertId;
      }
}

module.exports = new SetRepository();
