import 'package:flutter/material.dart';
import 'package:yarvolley_app/data/api_service.dart';
import 'package:yarvolley_app/data/league_repo.dart';
import 'package:yarvolley_app/domain/league.dart';

class LeagueSelectScreen extends StatelessWidget {
  const LeagueSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Список лиг')),
      body: FutureBuilder<List<League>>(
        future: LeagueRepository(ApiClient()).getLeagues(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(
                    snapshot.data![index].isActive ? 'Активна' : 'Неактивна',
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
