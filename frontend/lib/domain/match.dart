// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:collection/collection.dart';

import 'package:yarvolley_app/domain/set.dart';

class Match {
  int id;
  DateTime date;
  String location;
  bool isUpcoming;
  int firstTeamId;
  int secondTeamId;
  int leagueId;
  int firstTeamScore;
  int secondTeamScore;
  int winnerTeamId;
  List<Set> setList;
  Match({
    required this.id,
    required this.date,
    required this.location,
    required this.isUpcoming,
    required this.firstTeamId,
    required this.secondTeamId,
    required this.leagueId,
    required this.firstTeamScore,
    required this.secondTeamScore,
    required this.winnerTeamId,
    required this.setList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'location': location,
      'isUpcoming': isUpcoming,
      'firstTeamId': firstTeamId,
      'secondTeamId': secondTeamId,
      'leagueId': leagueId,
      'firstTeamScore': firstTeamScore,
      'secondTeamScore': secondTeamScore,
      'winnerTeamId': winnerTeamId,
      'setList': setList.map((x) => x.toMap()).toList(),
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      id: map['id'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      location: map['location'] as String,
      isUpcoming: map['isUpcoming'] as bool,
      firstTeamId: map['firstTeamId'] as int,
      secondTeamId: map['secondTeamId'] as int,
      leagueId: map['leagueId'] as int,
      firstTeamScore: map['firstTeamScore'] as int,
      secondTeamScore: map['secondTeamScore'] as int,
      winnerTeamId: map['winnerTeamId'] as int,
      setList: List<Set>.from(
        (map['setList'] as List<int>).map<Set>(
          (x) => Set.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Match.fromJson(String source) =>
      Match.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Match(id: $id, date: $date, location: $location, isUpcoming: $isUpcoming, firstTeamId: $firstTeamId, secondTeamId: $secondTeamId, leagueId: $leagueId, firstTeamScore: $firstTeamScore, secondTeamScore: $secondTeamScore, winnerTeamId: $winnerTeamId, setList: $setList)';
  }

  @override
  bool operator ==(covariant Match other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.date == date &&
        other.location == location &&
        other.isUpcoming == isUpcoming &&
        other.firstTeamId == firstTeamId &&
        other.secondTeamId == secondTeamId &&
        other.leagueId == leagueId &&
        other.firstTeamScore == firstTeamScore &&
        other.secondTeamScore == secondTeamScore &&
        other.winnerTeamId == winnerTeamId &&
        listEquals(other.setList, setList);
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
        winnerTeamId.hashCode ^
        setList.hashCode;
  }

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
    List<Set>? setList,
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
      setList: setList ?? this.setList,
    );
  }
}
