import 'dart:convert';

import 'package:yarvolley_app/data/api_service.dart';
import 'package:yarvolley_app/domain/league.dart';

class LeagueRepository {
  final ApiClient apiClient;

  LeagueRepository(this.apiClient);

  // Future<List<League>> getLeagues() async {
  //   final response = await apiClient.get('leagues');
  //   if (response.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(response.body);
  //     return body.map((json) => League.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Не удалось загрузить лиги');
  //   }
  // }

  Future<List<League>> getLeagues() async {
    final response = await apiClient.get('leagues');
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body
          .map((json) => League.fromMap(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Не удалось загрузить лиги');
    }
  }
}
