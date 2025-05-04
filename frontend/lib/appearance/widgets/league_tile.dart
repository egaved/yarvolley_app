import 'package:flutter/material.dart';
import 'package:yarvolley_app/domain/league.dart';

class LeagueTile extends StatelessWidget {
  final League league;

  const LeagueTile({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      title: Text(
        league.name,
        style: const TextStyle(
          fontFamily: 'AppCommonFont',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      tileColor: const Color(0xFFF3F3F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      onTap: () {
        // TODO
      },
    );
  }
}
