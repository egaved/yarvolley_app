import 'dart:convert';

import 'package:yarvolley_app/data/domain/player.dart';
import 'package:yarvolley_app/services/api_service.dart';

class PlayerRepository {
  final ApiClient _apiClient;

  PlayerRepository(this._apiClient);

  Future<List<Player>> getTeamPlayers(int teamId) async {
    final response = await _apiClient.get('teams/$teamId/players');

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body
          .map((json) => Player.fromMap(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Не удалось загрузить матчи. (client side)');
    }
  }
}
