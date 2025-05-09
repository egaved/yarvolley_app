import 'dart:convert';
import 'dart:core';

import 'package:equatable/equatable.dart';

class Match extends Equatable {
  final int id;
  final DateTime date;
  final String location;
  final bool isUpcoming;
  final int firstTeamId;
  final int secondTeamId;
  final int leagueId;
  final int? firstTeamScore;
  final int? secondTeamScore;
  final int? winnerTeamId;

  const Match({
    required this.id,
    required this.date,
    required this.location,
    required this.firstTeamId,
    required this.secondTeamId,
    required this.leagueId,
    this.isUpcoming = true,
    this.firstTeamScore,
    this.secondTeamScore,
    this.winnerTeamId,
  });

  const Match.completed({
    required this.id,
    required this.date,
    required this.location,
    required this.firstTeamId,
    required this.secondTeamId,
    required this.leagueId,
    required this.firstTeamScore,
    required this.secondTeamScore,
    required this.winnerTeamId,
  }) : isUpcoming = false;

  Match copyWith({
    int? id,
    DateTime? date,
    String? location,
    bool? isUpcoming,
    int? firstTeamId,
    int? secondTeamId,
    int? leagueId,
    int? firstTeamScore,
    int? secondTeamScore,
    int? winnerTeamId,
  }) {
    return Match(
      id: id ?? this.id,
      date: date ?? this.date,
      location: location ?? this.location,
      isUpcoming: isUpcoming ?? this.isUpcoming,
      firstTeamId: firstTeamId ?? this.firstTeamId,
      secondTeamId: secondTeamId ?? this.secondTeamId,
      leagueId: leagueId ?? this.leagueId,
      firstTeamScore: firstTeamScore ?? this.firstTeamScore,
      secondTeamScore: secondTeamScore ?? this.secondTeamScore,
      winnerTeamId: winnerTeamId ?? this.winnerTeamId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.toIso8601String(),
      'location': location,
      'is_upcoming': isUpcoming ? 1 : 0,
      'team1_id': firstTeamId,
      'team2_id': secondTeamId,
      'league_id': leagueId,
      'team1_total_score': firstTeamScore,
      'team2_total_score': secondTeamScore,
      'winner_team_id': winnerTeamId,
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    return Match(
      id: map['id'] as int,
      date: DateTime.parse(map['date'] as String),
      location: map['location'] as String,
      isUpcoming: map['is_upcoming'] == 1,
      firstTeamId: map['team1_id'] as int,
      secondTeamId: map['team2_id'] as int,
      leagueId: map['league_id'] as int,
      firstTeamScore: parseInt(map['team1_total_score']),
      secondTeamScore: parseInt(map['team2_total_score']),
      winnerTeamId: parseInt(map['winner_team_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Match.fromJson(String source) =>
      Match.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Match(id: $id, date: $date, location: $location, isUpcoming: $isUpcoming, firstTeamId: $firstTeamId, secondTeamId: $secondTeamId, leagueId: $leagueId, firstTeamScore: $firstTeamScore, secondTeamScore: $secondTeamScore, winnerTeamId: $winnerTeamId)';
  }

  @override
  List<Object> get props => [
    id,
    date,
    location,
    isUpcoming,
    firstTeamId,
    secondTeamId,
    leagueId,
  ];
}
