import 'package:flutter/material.dart';
import 'package:yarvolley_app/appearance/screens/greeting_page.dart';
// import 'package:yarvolley_app/appearance/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YarVolley',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LeagueSelectScreen(),
    );
  }
}
