import 'package:flutter/material.dart';
import 'package:yarvolley_app/presentation/widgets/team/team_page_appbar.dart';

class TeamDetailsWidget extends StatefulWidget {
  final List<String> teamNames;

  const TeamDetailsWidget({super.key, required this.teamNames});

  @override
  State<TeamDetailsWidget> createState() => _TeamDetailsWidgetState();
}

class _TeamDetailsWidgetState extends State<TeamDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    void onTeamSelected(int index) {
      print('Выбрана команда: ${widget.teamNames[index]}');
    }

    return Scaffold(
      appBar: ListAppBar(
        teamNames: widget.teamNames,
        onTeamSelected: onTeamSelected,
      ),
    );
  }
}
