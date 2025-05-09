import 'dart:convert';
import 'package:equatable/equatable.dart';

class League extends Equatable {
  final int id;
  final String name;
  final bool isActive;

  const League({required this.id, required this.name, required this.isActive});

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
  List<Object> get props => [id, name, isActive];
}
