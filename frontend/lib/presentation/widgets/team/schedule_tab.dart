import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yarvolley_app/data/domain/team.dart';
import 'package:yarvolley_app/data/domain/match.dart';
import 'package:yarvolley_app/data/repositories/match_repo.dart';
import 'package:yarvolley_app/logic/cubits/match_cubit.dart';

class ScheduleTab extends StatelessWidget {
  final Team team;

  const ScheduleTab({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchCubit, MatchState>(
      builder: (context, state) {
        if (state is MatchInitial || state is MatchLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MatchLoaded) {
          final matches = state.matches;

          return _ScheduleTabView(
            matches: matches,
            team: team,
            teamNames: state.teamNames,
          );
        } else if (state is MatchError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Неизвестное состояние'));
      },
    );
  }
}

class _ScheduleTabView extends StatelessWidget {
  final List<Match> matches;
  final Team team;
  final Map<int, String> teamNames;
  const _ScheduleTabView({
    required this.matches,
    required this.team,
    required this.teamNames,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        headingRowHeight: 40.0,
        columns: const [
          DataColumn(label: Text('Дата')),
          DataColumn(label: Text('Соперник')),
          DataColumn(label: Text('Результат')),
        ],
        rows:
            matches.map((match) {
              final opponent =
                  match.firstTeamId == team.id
                      ? teamNames[match.secondTeamId]
                      : teamNames[match.firstTeamId];

              String result = "";
              if (!match.isUpcoming) {
                result = "${match.firstTeamScore} : ${match.secondTeamScore}";
              }

              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      '${match.date.day.toString().padLeft(2, '0')}.${match.date.month.toString().padLeft(2, '0')}.${match.date.year}',
                    ),
                  ),
                  DataCell(
                    Text(
                      opponent!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DataCell(
                    Text(
                      result,
                      style: TextStyle(
                        color:
                            team.id == match.winnerTeamId
                                ? Colors.green
                                : Colors.red,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
