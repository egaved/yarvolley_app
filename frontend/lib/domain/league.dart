// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:collection/collection.dart';

import 'package:yarvolley_app/domain/standing.dart';
import 'package:yarvolley_app/domain/team.dart';
import 'package:yarvolley_app/domain/match.dart';

class League {
  int id;
  String name;
  bool isActive;
  Standing standing;
  List<Team> teamList;
  List<Match> matchList;

  League({
    required this.id,
    required this.name,
    required this.isActive,
    required this.standing,
    required this.teamList,
    required this.matchList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isActive': isActive,
      'standing': standing.toMap(),
      'teamList': teamList.map((x) => x.toMap()).toList(),
      'matchList': matchList.map((x) => x.toMap()).toList(),
    };
  }

  factory League.fromMap(Map<String, dynamic> map) {
    return League(
      id: map['id'] as int,
      name: map['name'] as String,
      isActive: map['isActive'] as bool,
      standing: Standing.fromMap(map['standing'] as Map<String, dynamic>),
      teamList: List<Team>.from(
        (map['teamList'] as List<int>).map<Team>(
          (x) => Team.fromMap(x as Map<String, dynamic>),
        ),
      ),
      matchList: List<Match>.from(
        (map['matchList'] as List<int>).map<Match>(
          (x) => Match.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory League.fromJson(String source) =>
      League.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'League(id: $id, name: $name, isActive: $isActive, standing: $standing, teamList: $teamList, matchList: $matchList)';
  }

  @override
  bool operator ==(covariant League other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        other.isActive == isActive &&
        other.standing == standing &&
        listEquals(other.teamList, teamList) &&
        listEquals(other.matchList, matchList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isActive.hashCode ^
        standing.hashCode ^
        teamList.hashCode ^
        matchList.hashCode;
  }

  League copyWith({
    int? id,
    String? name,
    bool? isActive,
    Standing? standing,
    List<Team>? teamList,
    List<Match>? matchList,
  }) {
    return League(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      standing: standing ?? this.standing,
      teamList: teamList ?? this.teamList,
      matchList: matchList ?? this.matchList,
    );
  }
}
