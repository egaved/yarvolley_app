// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

class Match {
  int id;
  DateTime date;
  String location;
  bool isUpcoming;
  int firstTeamId;
  int secondTeamId;
  int leagueId;
  int? firstTeamScore;
  int? secondTeamScore;
  int? winnerTeamId;

  Match({
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

  Match.completed({
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
      'date': date.millisecondsSinceEpoch,
      'location': location,
      'is_upcoming': isUpcoming,
      'team1_id': firstTeamId,
      'team2_id': secondTeamId,
      'league_id': leagueId,
      'team1_total_score': firstTeamScore,
      'team2_total_score': secondTeamScore,
      'winner_team_id': winnerTeamId,
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      id: map['id'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      location: map['location'] as String,
      isUpcoming: map['is_upcoming'] as bool,
      firstTeamId: map['team1_id'] as int,
      secondTeamId: map['team2_id'] as int,
      leagueId: map['league_id'] as int,
      firstTeamScore: map['team1_total_score'] as int,
      secondTeamScore: map['team2_total_score'] as int,
      winnerTeamId: map['winner_team_id'] as int,
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
  bool operator ==(covariant Match other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.location == location &&
        other.isUpcoming == isUpcoming &&
        other.firstTeamId == firstTeamId &&
        other.secondTeamId == secondTeamId &&
        other.leagueId == leagueId &&
        other.firstTeamScore == firstTeamScore &&
        other.secondTeamScore == secondTeamScore &&
        other.winnerTeamId == winnerTeamId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        location.hashCode ^
        isUpcoming.hashCode ^
        firstTeamId.hashCode ^
        secondTeamId.hashCode ^
        leagueId.hashCode ^
        firstTeamScore.hashCode ^
        secondTeamScore.hashCode ^
        winnerTeamId.hashCode;
  }
}
