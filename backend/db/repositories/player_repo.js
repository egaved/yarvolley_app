const pool = require('../../config/connection');

class PlayerRepository {
    async createPlayer(data) {
        const { name, birth_year, height, team_id } = data;
        const [result] = await pool.query(
            'INSERT INTO player (id, name, birth_year, height, team_id) VALUES (NULL, ?, ?, ?, ?)',
            [name, birth_year, height, team_id]
        );
        return result.insertId;
    }

    async getPlayersByTeamId(teamId) {
        const [rows] = await pool.query(`
            SELECT * 
            FROM player 
            WHERE team_id = ?
        `, [teamId]);
        return rows;
    }
}

module.exports = new PlayerRepository();
