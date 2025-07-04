import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/repositories/league_repo.dart';
import 'package:yarvolley_app/data/repositories/match_repo.dart';
import 'package:yarvolley_app/data/repositories/player_repo.dart';
import 'package:yarvolley_app/data/repositories/standing_repo.dart';
import 'package:yarvolley_app/data/repositories/team_repo.dart';
import 'package:yarvolley_app/presentation/screens/league_select_page.dart';
import 'package:yarvolley_app/presentation/screens/main_page.dart';
import 'package:yarvolley_app/services/api_service.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

Future<Widget> getInitialScreen(PreferencesService preferencesService) async {
  try {
    final hasData = await preferencesService.hasData('favorite_leagues');
    return hasData ?? false ? const MainScreen() : const LeagueSelectScreen();
  } catch (e) {
    debugPrint('Error checking favorite leagues: $e');
    return const LeagueSelectScreen();
  }
}

class YarVolleyApp extends StatelessWidget {
  const YarVolleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getInitialScreen(context.read<PreferencesService>()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => TeamRepository(ApiClient())),
        RepositoryProvider(create: (context) => LeagueRepository(ApiClient())),
        RepositoryProvider(create: (context) => PreferencesService()),
        RepositoryProvider(create: (context) => MatchRepository(ApiClient())),
        RepositoryProvider(create: (context) => PlayerRepository(ApiClient())),
        RepositoryProvider(
          create: (context) => StandingRepository(ApiClient()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YarVolley',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const YarVolleyApp(),
      ),
    );
  }
}
