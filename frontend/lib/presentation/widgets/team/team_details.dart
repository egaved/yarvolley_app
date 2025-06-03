import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/team.dart';
import 'package:yarvolley_app/logic/cubits/match_cubit.dart';
import 'package:yarvolley_app/logic/cubits/player_cubit.dart';
import 'package:yarvolley_app/logic/cubits/team_cubit.dart';
import 'package:yarvolley_app/presentation/screens/team_select_page.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';
import 'package:yarvolley_app/presentation/theme/images.dart';
import 'package:yarvolley_app/presentation/widgets/list_app_bar.dart';
import 'package:yarvolley_app/presentation/widgets/team/roster_tab.dart';
import 'package:yarvolley_app/presentation/widgets/team/schedule_tab.dart';

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
  late Team selectedTeam;

  @override
  void initState() {
    super.initState();
    selectedTeam = widget.teams.first;
    if (widget.teams.isNotEmpty) {
      context.read<MatchCubit>().loadTeamMatches(selectedTeam.id);
      context.read<PlayerCubit>().loadTeamPlayers(selectedTeam.id);
    }
  }

  void onTeamSelected(Team team) {
    setState(() {
      selectedTeam = team;
    });
    context.read<MatchCubit>().loadTeamMatches(selectedTeam.id);
    context.read<PlayerCubit>().loadTeamPlayers(selectedTeam.id);
  }

  @override
  void didUpdateWidget(covariant TeamDetailsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.teams != oldWidget.teams) {
      if (widget.teams.isNotEmpty) {
        if (!widget.teams.contains(selectedTeam)) {
          selectedTeam = widget.teams.first;
        }
      } else {
        throw Exception("Нет избранных лиг");
      }
    }
    context.read<MatchCubit>().loadTeamMatches(selectedTeam.id);
    context.read<PlayerCubit>().loadTeamPlayers(selectedTeam.id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ListAppBar<Team>(
          items: widget.teams,
          nameGetter: (team) => team.name,
          onSelected: onTeamSelected,
          selectScreenBuilder: () => TeamSelectScreen(),
          onSelectScreenPopped:
              () => setState(() {
                context.read<TeamCubit>().loadFavoriteTeams();
              }),
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

            Container(
              color: primaryColor,
              child: const TabBar(
                tabs: [Tab(text: 'Расписание'), Tab(text: 'Состав')],
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                enableFeedback: false,
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
