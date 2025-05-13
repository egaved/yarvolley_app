import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/repositories/league_repo.dart';
import 'package:yarvolley_app/data/repositories/match_repo.dart';
import 'package:yarvolley_app/data/repositories/team_repo.dart';
import 'package:yarvolley_app/presentation/screens/home_page.dart';
import 'package:yarvolley_app/presentation/screens/league_select.dart';
import 'package:yarvolley_app/presentation/screens/team_select.dart';
import 'package:yarvolley_app/presentation/screens/teams_page.dart';
import 'package:yarvolley_app/services/api_service.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

Future<Widget> getInitialScreen(PreferencesService preferencesService) async {
  try {
    final hasData = await preferencesService.hasData('favorite_leagues');
    // return hasData ?? false ? const HomeScreen() : const LeagueSelectScreen();
    return const TeamSelectScreen();
  } catch (e) {
    debugPrint('Error checking favorite leagues: $e');
    return const TeamSelectScreen();
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
      ],
      child: MaterialApp(
        title: 'YarVolley',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const YarVolleyApp(),
      ),
    );
  }
}
