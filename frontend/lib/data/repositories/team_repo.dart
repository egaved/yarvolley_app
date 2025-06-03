import 'dart:convert';

import 'package:yarvolley_app/presentation/dto/league_dto.dart';
import 'package:yarvolley_app/services/api_service.dart';
import 'package:yarvolley_app/data/domain/team.dart';

class TeamRepository {
  final ApiClient _apiClient;

  TeamRepository(this._apiClient);

  Future<List<Team>> getLeagueTeams(int leagueId) async {
    final response = await _apiClient.get('leagues/$leagueId/teams');
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body
          .map((json) => Team.fromMap(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Не удалось получить данные о командах. (client side)');
    }
  }

  Future<Team> getTeamById(int teamId) async {
    final response = await _apiClient.get('teams/$teamId');
    if (response.statusCode == 200) {
      try {
        final json = jsonDecode(response.body);
        return Team.fromMap(json as Map<String, dynamic>);
      } catch (e) {
        throw Exception('Неверный формат данных: $e');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Команда с ID $teamId не найдена');
    } else {
      throw Exception('Ошибка загрузки данных: HTTP ${response.statusCode}');
    }
  }

  Future<List<LeagueDisplay>> getLeaguesWithTeams(Set<int> leagueIds) async {
    final response = await _apiClient.get(
      'favorite_leagues_teams?league_ids=${leagueIds.join(',')}',
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => LeagueDisplay.fromJson(json)).toList();
    } else {
      throw Exception('Не удалось загрузить лиги');
    }
  }
}
