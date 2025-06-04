const pool = require('../../config/connection');

class StandingRepository {
    async getLeagueStandings(leagueId) {
        const [rows] = await pool.query(`
            SELECT s.*, t.name as team_name
            FROM standing s
            JOIN Team t on s.team_id = t.id
            WHERE s.league_id = ?
            ORDER BY s.points DESC
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

        const [result] = await pool.query(`
            INSERT INTO standing (id, game_amount, wins, losses,
             position, balance, points, updated_at, league_id, team_id)
            VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?)  
        `, [game_amount, wins, losses, position, balance, points, updated_at, league_id, team_id]);
        return result.insertId;
    }

}

module.exports = new StandingRepository();