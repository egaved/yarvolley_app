const pool = require('../../config/connection');

class LeagueRepository {

    async getAllLeagues() {
        const [rows] = await pool.query(`
            SELECT * FROM league
        `);
        return rows;
    }

    async getLeagueById(leagueId) {
        const [rows] = await pool.query(`
            SELECT * FROM league
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
            INSERT INTO league (id, name, is_active)
            VALUES (NULL, ?, ?)    
        `, [name, is_active]
        );
        return result.insertId;
    }
}

module.exports = new LeagueRepository();