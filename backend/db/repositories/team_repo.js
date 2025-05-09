const pool = require('../../config/connection.js');

class TeamRepository {
  async getAllTeams() {
    const [rows] = await pool.query(`
      SELECT id, name, league_id 
      FROM Team
    `);
    return rows;
  }

  async getTeamsNames(teamIds) {
    const [rows] = await pool.query(`
      SELECT id, name FROM Team
      WHERE id IN (?)
    `, [teamIds]);
    return rows;
  }

  async getTeamsByLeagueId(leagueId) {
    const [rows] = await pool.query(`
      SELECT * FROM Team
      WHERE league_id = ?
    `, [leagueId]);
    return rows;
  }

  async getTeamById(teamId) {
    const [rows] = await pool.query(`
      SELECT * FROM Team 
      WHERE id = ?
    `, [teamId]); 
  
    if (rows.length === 0) {
      return null;
    }
    return rows[0];
  }

  async createTeam(data) {
    const { name, league_id } = data;
    const [result] = await pool.query(
      `INSERT INTO Team (id, name, league_id) VALUES (NULL, ?, ?)`,
      [name, league_id]
    );
    return result.insertId;
  }
}

module.exports = new TeamRepository();