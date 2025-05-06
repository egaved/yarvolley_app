import 'package:flutter/material.dart';
import 'package:yarvolley_app/appearance/screens/home_page.dart';
import 'package:yarvolley_app/appearance/theme/colors.dart';
import 'package:yarvolley_app/appearance/widgets/common_app_bar.dart';
import 'package:yarvolley_app/appearance/widgets/league_item.dart';
import 'package:yarvolley_app/services/api_service.dart';
import 'package:yarvolley_app/data/league_repo.dart';
import 'package:yarvolley_app/domain/league.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

class LeagueSelectScreen extends StatefulWidget {
  const LeagueSelectScreen({super.key});

  @override
  State<LeagueSelectScreen> createState() => _LeagueSelectScreenState();
}

class _LeagueSelectScreenState extends State<LeagueSelectScreen> {
  int _favoriteCount = 0;
  final PreferencesService _favoriteService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _loadFavoriteCount();
  }

  Future<void> _loadFavoriteCount() async {
    final leagues = await _favoriteService.getFavoriteLeagueIds();
    setState(() {
      _favoriteCount = leagues.length;
    });
  }

  // Обновление состояния при изменении избранного
  void _updateFavoriteCount() async {
    final leagues = await _favoriteService.getFavoriteLeagueIds();
    setState(() {
      _favoriteCount = leagues.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonPageAppBar(title: 'Выберите лиги'),
      body: Column(
        children: [
          FutureBuilder<List<League>>(
            future: LeagueRepository(ApiClient()).getLeagues(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final league = snapshot.data![index];
                      return LeagueItem(
                        league: league,
                        favoriteService: _favoriteService,
                        onFavoriteChanged: _updateFavoriteCount,
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 25),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          onPressed:
              _favoriteCount > 0
                  ? () {
                    // Перейти на домашнюю страницу
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                  : null,
          child: Text('Завершить'),
        ),
      ),
    );
  }
}
