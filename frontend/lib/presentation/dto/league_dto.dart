import 'package:yarvolley_app/presentation/dto/team_dto.dart';

class LeagueDisplay {
  final int id;
  final String name;
  final List<TeamDisplay> teams;

  LeagueDisplay({required this.id, required this.name, required this.teams});

  factory LeagueDisplay.fromJson(Map<String, dynamic> json) {
    return LeagueDisplay(
      id: json['league_id'],
      name: json['league_name'],
      teams:
          (json['teams'] as List)
              .map((teamJson) => TeamDisplay.fromJson(teamJson))
              .toList(),
    );
  }
}
