// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

class League {
  int id;
  String name;
  bool isActive;

  League({required this.id, required this.name, required this.isActive});

  League copyWith({int? id, String? name, bool? isActive}) {
    return League(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory League.fromMap(Map<String, dynamic> map) {
    return League(
      id: map['id'] as int,
      name: map['name'] as String,
      isActive: map['is_active'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory League.fromJson(String source) =>
      League.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'League(id: $id, name: $name, isActive: $isActive)';

  @override
  bool operator ==(covariant League other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.isActive == isActive;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isActive.hashCode;
}
