const pool = require('../../config/connection.js');

class TeamRepository {
  async getAllTeams() {
    const [rows] = await pool.query(`
      SELECT id, name, league_id 
      FROM team
    `);
    return rows;
  }

  async getTeamsNames(teamIds) {
    const [rows] = await pool.query(`
      SELECT id, name FROM team
      WHERE id IN (?)
    `, [teamIds]);
    return rows;
  }

  async getTeamsByLeagueIdList(leagueIdList) {
    const [rows] = await pool.query(`
      SELECT l.id AS league_id, l.name AS league_name, t.id AS team_id, t.name AS team_name
      FROM league l
      JOIN team t ON l.id = t.league_id
        WHERE l.id IN (?)
        ORDER BY l.id, t.id
    `, [leagueIdList])
    return rows;
  }

  async getTeamsByLeagueId(leagueId) {
    const [rows] = await pool.query(`
      SELECT * FROM team
      WHERE league_id = ?
    `, [leagueId]);
    return rows;
  }

  async getTeamById(teamId) {
    const [rows] = await pool.query(`
      SELECT * FROM team 
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
      `INSERT INTO team (id, name, league_id) VALUES (NULL, ?, ?)`,
      [name, league_id]
    );
    return result.insertId;
  }
}

module.exports = new TeamRepository();