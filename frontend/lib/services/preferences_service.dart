import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<bool?> hasData(String key) async {
    final data = await getIds(key);
    return data.isNotEmpty;
  }

  Future<List<int>> getIds(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? stringList = prefs.getStringList(key);
    return stringList?.map((str) => int.parse(str)).toList() ?? [];
  }

  Future<void> addFavoriteItem(String key, int id) async {
    final prefs = await SharedPreferences.getInstance();
    final List<int> ids = await getIds(key);
    if (!ids.contains(id)) {
      final List<String> stringList =
          ids.map((id) => id.toString()).toList()..add(id.toString());
      await prefs.setStringList(key, stringList);
    }
  }

  Future<void> removeFavoriteItem(String key, int idToRemove) async {
    final prefs = await SharedPreferences.getInstance();
    final List<int> ids = await getIds(key);
    final List<String> stringList =
        ids.where((id) => id != idToRemove).map((id) => id.toString()).toList();
    await prefs.setStringList(key, stringList);
  }

  Future<bool> isItemFavorite(String key, int id) async {
    final List<int> ids = await getIds(key);
    return ids.contains(id);
  }
}
