// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

class Set {
  int id;
  int setNumber;
  int firstTeamScore;
  int secondTeamScore;
  int matchId;
  Set({
    required this.id,
    required this.setNumber,
    required this.firstTeamScore,
    required this.secondTeamScore,
    required this.matchId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'setNumber': setNumber,
      'firstTeamScore': firstTeamScore,
      'secondTeamScore': secondTeamScore,
      'matchId': matchId,
    };
  }

  factory Set.fromMap(Map<String, dynamic> map) {
    return Set(
      id: map['id'] as int,
      setNumber: map['setNumber'] as int,
      firstTeamScore: map['firstTeamScore'] as int,
      secondTeamScore: map['secondTeamScore'] as int,
      matchId: map['matchId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Set.fromJson(String source) =>
      Set.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Set(id: $id, setNumber: $setNumber, firstTeamScore: $firstTeamScore, secondTeamScore: $secondTeamScore, matchId: $matchId)';
  }

  @override
  bool operator ==(covariant Set other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.setNumber == setNumber &&
        other.firstTeamScore == firstTeamScore &&
        other.secondTeamScore == secondTeamScore &&
        other.matchId == matchId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        setNumber.hashCode ^
        firstTeamScore.hashCode ^
        secondTeamScore.hashCode ^
        matchId.hashCode;
  }

  Set copyWith({
    int? id,
    int? setNumber,
    int? firstTeamScore,
    int? secondTeamScore,
    int? matchId,
  }) {
    return Set(
      id: id ?? this.id,
      setNumber: setNumber ?? this.setNumber,
      firstTeamScore: firstTeamScore ?? this.firstTeamScore,
      secondTeamScore: secondTeamScore ?? this.secondTeamScore,
      matchId: matchId ?? this.matchId,
    );
  }
}
