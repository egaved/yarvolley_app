// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

class Standing {
  final int id;
  final int gameAmount;
  final int wins;
  final int losses;
  final int position;
  final int balance;
  final int points;
  final DateTime updatedAt;
  final int leagueId;
  final int teamId;
  final String? teamName;
  Standing({
    required this.id,
    required this.gameAmount,
    required this.wins,
    required this.losses,
    required this.position,
    required this.balance,
    required this.points,
    required this.updatedAt,
    required this.leagueId,
    required this.teamId,
    this.teamName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'gameAmount': gameAmount,
      'wins': wins,
      'losses': losses,
      'position': position,
      'balance': balance,
      'points': points,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'league_id': leagueId,
      'team_id': teamId,
    };
  }

  factory Standing.fromMap(Map<String, dynamic> map) {
    return Standing(
      id: map['id'] as int,
      gameAmount: map['game_amount'] as int,
      wins: map['wins'] as int,
      losses: map['losses'] as int,
      position: map['position'] as int,
      balance: map['balance'] as int,
      points: map['points'] as int,
      updatedAt: DateTime.parse(map['updated_at'] as String),
      leagueId: map['league_id'] as int,
      teamId: map['team_id'] as int,
      teamName: map['team_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Standing.fromJson(String source) =>
      Standing.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Standing(id: $id, gameAmount: $gameAmount, wins: $wins, losses: $losses, position: $position, balance: $balance, points: $points, updatedAt: $updatedAt, leagueId: $leagueId, teamId: $teamId)';
  }

  @override
  bool operator ==(covariant Standing other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.gameAmount == gameAmount &&
        other.wins == wins &&
        other.losses == losses &&
        other.position == position &&
        other.balance == balance &&
        other.points == points &&
        other.updatedAt == updatedAt &&
        other.leagueId == leagueId &&
        other.teamId == teamId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gameAmount.hashCode ^
        wins.hashCode ^
        losses.hashCode ^
        position.hashCode ^
        balance.hashCode ^
        points.hashCode ^
        updatedAt.hashCode ^
        leagueId.hashCode ^
        teamId.hashCode;
  }
}
