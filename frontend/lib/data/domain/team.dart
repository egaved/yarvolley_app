// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final int id;
  final String name;
  final int leagueId;

  const Team({required this.id, required this.name, required this.leagueId});

  Team copyWith({int? id, String? name, int? leagueId}) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      leagueId: leagueId ?? this.leagueId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'league_id': leagueId};
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] as int,
      name: map['name'] as String,
      leagueId: map['league_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) =>
      Team.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Team(id: $id, name: $name, leagueId: $leagueId)';

  @override
  List<Object> get props => [id, name, leagueId];
}
