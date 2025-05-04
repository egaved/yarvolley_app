import 'package:flutter/material.dart';
import 'package:yarvolley_app/appearance/widgets/common_app_bar.dart';
import 'package:yarvolley_app/appearance/widgets/league_item.dart';
import 'package:yarvolley_app/services/api_service.dart';
import 'package:yarvolley_app/data/league_repo.dart';
import 'package:yarvolley_app/domain/league.dart';
import 'package:yarvolley_app/services/favorite_leagues_service.dart';

class LeagueSelectScreen extends StatelessWidget {
  final FavoriteLeaguesService _favoriteService = FavoriteLeaguesService();

  LeagueSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonPageAppBar(title: 'Выберите лиги'),
      body: Column(
        children: [
          Container(),
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
    );
  }
}
