class TeamDisplay {
  final int id;
  final String name;

  TeamDisplay({required this.id, required this.name});

  factory TeamDisplay.fromJson(Map<String, dynamic> json) {
    return TeamDisplay(id: json['team_id'], name: json['team_name']);
  }
}
