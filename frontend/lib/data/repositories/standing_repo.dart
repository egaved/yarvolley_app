import 'dart:convert';

import 'package:yarvolley_app/data/domain/standing.dart';
import 'package:yarvolley_app/services/api_service.dart';

class StandingRepository {
  final ApiClient _apiClient;

  StandingRepository(this._apiClient);

  Future<List<Standing>> getLeagueStandings(int leagueId) async {
    final response = await _apiClient.get("leagues/$leagueId/standings");

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body
          .map((json) => Standing.fromMap(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Не удалось загрузить матчи. (client side)');
    }
  }
}
