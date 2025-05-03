const pool = require('../../config/connection');

class LeagueRepository {

    async getAllLeagues() {
        const [rows] = await pool.query(`
            SELECT * FROM League
        `);
        return rows;
    }

    async getLeagueById(leagueId) {
        const [rows] = await pool.query(`
            SELECT * FROM League
            WHERE id = ?
        `, [leagueId]);
        if (rows.length === 0) {
            return null;
        }
        return rows[0];
    }

    async createLeague(data) {
        const { name, is_active } = data;
        const [result] = await pool.query(`
            INSERT INTO League (id, name, is_active)
            VALUES (NULL, ?, ?)    
        `, [name, is_active]
        );
        return result.insertId;
    }
}

module.exports = new LeagueRepository();