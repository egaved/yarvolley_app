import 'dart:convert';

import 'package:yarvolley_app/services/api_service.dart';
import 'package:yarvolley_app/data/domain/match.dart';

class MatchRepository {
  final ApiClient _apiClient;
  final Map<int, String> _teamNamesCache = {};

  MatchRepository(this._apiClient);

  Future<List<Match>> getLeagueMatches(int leagueId) async {
    final response = await _apiClient.get('leagues/$leagueId/matches');
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body
          .map((json) => Match.fromMap(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Не удалось загрзить матчи. (client side)');
    }
  }

  Future<List<Match>> getTeamMatches(int teamId) async {
    final response = await _apiClient.get('teams/$teamId/matches');
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body
          .map((json) => Match.fromMap(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Не удалось загрзить матчи');
    }
  }

  Future<Map<int, String>> getTeamNames(Set<int> teamIds) async {
    // Фильтруем ID, которых нет в кэше
    final Set<int> missingIds =
        teamIds.where((id) => !_teamNamesCache.containsKey(id)).toSet();

    if (missingIds.isNotEmpty) {
      final response = await _apiClient.get(
        'teams?ids=${missingIds.join(',')}',
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        // Обновляем кэш
        for (var team in body) {
          final id = team['id'] as int;
          final name = team['name'] as String;
          _teamNamesCache[id] = name;
        }
      } else {
        throw Exception(
          'Failed to fetch team names: HTTP ${response.statusCode}',
        );
      }
    }
    // Возвращаем объединенные данные из кэша
    return {for (var id in teamIds) id: _teamNamesCache[id] ?? 'Unknown Team'};
  }
}
