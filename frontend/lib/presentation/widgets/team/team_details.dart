import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/team.dart';
import 'package:yarvolley_app/logic/cubits/match_cubit.dart';
import 'package:yarvolley_app/logic/cubits/player_cubit.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';
import 'package:yarvolley_app/presentation/theme/images.dart';
import 'package:yarvolley_app/presentation/widgets/team/roster_tab.dart';
import 'package:yarvolley_app/presentation/widgets/team/schedule_tab.dart';
import 'package:yarvolley_app/presentation/widgets/team/team_page_appbar.dart';
import 'package:yarvolley_app/data/repositories/match_repo.dart';

class TeamDetailsWidget extends StatefulWidget {
  final List<Team> teams;
  final VoidCallback unsubButtonAction;

  const TeamDetailsWidget({
    super.key,
    required this.teams,
    required this.unsubButtonAction,
  });

  @override
  State<TeamDetailsWidget> createState() => _TeamDetailsWidgetState();
}

class _TeamDetailsWidgetState extends State<TeamDetailsWidget> {
  late Team selectedTeam; // Поле класса для хранения состояния

  @override
  void initState() {
    // super.initState();
    // selectedTeam = widget.teams.first;
    super.initState();
    selectedTeam = widget.teams.first;
    if (widget.teams.isNotEmpty) {
      context.read<MatchCubit>().loadTeamMatches(selectedTeam.id);
      context.read<PlayerCubit>().loadTeamPlayers(selectedTeam.id);
    }
  }

  void onTeamSelected(int index) {
    setState(() {
      selectedTeam = widget.teams[index];
    });
    context.read<MatchCubit>().loadTeamMatches(selectedTeam.id);
    context.read<PlayerCubit>().loadTeamPlayers(selectedTeam.id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ListAppBar(
          teamNames: widget.teams.map((team) => team.name).toList(),
          onTeamSelected: onTeamSelected,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1),
              child: Container(
                decoration: BoxDecoration(color: primaryColor),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    spacing: 30,
                    children: [
                      SizedBox(height: 100, width: 100, child: noLogoIcon),
                      Text(
                        selectedTeam.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'AppCommonFont',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1, bottom: 1),
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: primaryColor),
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Icon(Icons.heart_broken_sharp, color: Colors.white),
                      Text(
                        'Убрать из избранного',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'AppCommonFont',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: primaryColor,
              child: const TabBar(
                tabs: [Tab(text: 'Расписание'), Tab(text: 'Состав')],
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ScheduleTab(team: selectedTeam),
                  RosterTab(team: selectedTeam),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
