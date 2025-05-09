// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

class Player {
  int id;
  String name;
  int birthYear;
  int height;
  int teamId;
  Player({
    required this.id,
    required this.name,
    required this.birthYear,
    required this.height,
    required this.teamId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'birth_year': birthYear,
      'height': height,
      'team_id': teamId,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'] as int,
      name: map['name'] as String,
      birthYear: map['birth_year'] as int,
      height: map['height'] as int,
      teamId: map['team_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) =>
      Player.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.birthYear == birthYear &&
        other.height == height &&
        other.teamId == teamId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        birthYear.hashCode ^
        height.hashCode ^
        teamId.hashCode;
  }
}
