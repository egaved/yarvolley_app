import 'dart:convert';

import 'package:yarvolley_app/presentation/dto/league_dto.dart';
import 'package:yarvolley_app/services/api_service.dart';
import 'package:yarvolley_app/data/domain/league.dart';

class LeagueRepository {
  final ApiClient _apiClient;

  LeagueRepository(this._apiClient);

  Future<List<League>> getLeagues() async {
    final response = await _apiClient.get('leagues');
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body
          .map((json) => League.fromMap(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Не удалось загрузить лиги');
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

  Future<League> getLeagueById(int leagueId) async {
    final response = await _apiClient.get('leagues/$leagueId');
    if (response.statusCode == 200) {
      try {
        final json = jsonDecode(response.body);
        return League.fromMap(json as Map<String, dynamic>);
      } catch (e) {
        throw Exception('Неверный формат данных: $e');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Команда с ID $leagueId не найдена');
    } else {
      throw Exception('Ошибка загрузки данных: HTTP ${response.statusCode}');
    }
  }
}
