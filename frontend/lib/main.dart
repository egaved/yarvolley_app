import 'package:flutter/material.dart';
import 'package:yarvolley_app/services/preferences_service.dart';
import 'package:yarvolley_app/appearance/screens/league_select.dart';
import 'package:yarvolley_app/appearance/screens/home_page.dart';

Future<Widget> getInitialScreen() async {
  try {
    final preferenceService = PreferencesService();
    final hasData = await preferenceService.hasFavoriteLeagues();
    // return hasData ?? false ? const HomePage() : LeagueSelectScreen();
    return LeagueSelectScreen();
  } catch (e) {
    return LeagueSelectScreen();
  }
}

class YarVolleyApp extends StatelessWidget {
  const YarVolleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getInitialScreen(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
      },
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YarVolley',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const YarVolleyApp(),
    );
  }
}
