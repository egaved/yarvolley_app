import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _favoriteLeaguesKey = 'favorite_leagues';

  Future<bool?> hasFavoriteLeagues() async {
    final data = await getFavoriteLeagueIds();
    return data.isNotEmpty;
  }

  Future<List<int>> getFavoriteLeagueIds() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? stringList = prefs.getStringList(_favoriteLeaguesKey);
    return stringList?.map((str) => int.parse(str)).toList() ?? [];
  }

  Future<void> addLeague(int leagueId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<int> ids = await getFavoriteLeagueIds();
    if (!ids.contains(leagueId)) {
      final List<String> stringList =
          ids.map((id) => id.toString()).toList()..add(leagueId.toString());
      await prefs.setStringList(_favoriteLeaguesKey, stringList);
    }
  }

  Future<void> removeLeague(int leagueId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<int> ids = await getFavoriteLeagueIds();
    final List<String> stringList =
        ids.where((id) => id != leagueId).map((id) => id.toString()).toList();
    await prefs.setStringList(_favoriteLeaguesKey, stringList);
  }

  Future<bool> isLeagueFavorite(int leagueId) async {
    final List<int> ids = await getFavoriteLeagueIds();
    return ids.contains(leagueId);
  }
}
