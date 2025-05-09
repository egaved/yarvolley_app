import 'dart:convert';

import 'package:yarvolley_app/services/api_service.dart';
import 'package:yarvolley_app/data/domain/match.dart';

class MatchRepository {
  final ApiClient _apiClient;

  MatchRepository(this._apiClient);

  Future<List<Match>> getLeagueMatches(int leagueId) async {
    final response = await _apiClient.get('leagues/$leagueId/matches');
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print('API response for leagueId $leagueId: $body');
      return body
          .map((json) => Match.fromMap(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Не удалось загрзить матчи');
    }
  }

  Future<List<Match>> getTeamMatches(String teamId) async {
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
}
