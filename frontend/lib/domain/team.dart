// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

class Team {
  int id;
  String name;
  int leagueId;
  int standingId;
  Team({
    required this.id,
    required this.name,
    required this.leagueId,
    required this.standingId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'leagueId': leagueId,
      'standingId': standingId,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] as int,
      name: map['name'] as String,
      leagueId: map['leagueId'] as int,
      standingId: map['standingId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) =>
      Team.fromMap(json.decode(source) as Map<String, dynamic>);
}
