const pool = require('../../config/connection');

class StandingRepository {
    async getLeagueStandings(leagueId) {
        const [rows] = await pool.query(`
            SELECT * FROM Standing
            WHERE league_id = ?
        `, [leagueId]);
        return rows;
    }

    async createStanding(data) {
        const {
            game_amount,
            wins,
            losses,
            position,
            balance,
            points,
            updated_at,
            league_id,
            team_id
        } = data;

        const[result] = await pool.query(`
            INSERT INTO Standing (id, game_amount, wins, losses,
             position, balance, points, updated_at, league_id, team_id)
            VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?)  
        `, [game_amount, wins, losses, position, balance, points, updated_at, league_id, team_id]);
        return result.insertId;
    }

}

module.exports = new StandingRepository();