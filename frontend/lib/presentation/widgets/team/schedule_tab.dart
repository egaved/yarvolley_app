import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/team.dart';
import 'package:yarvolley_app/data/domain/match.dart';
import 'package:yarvolley_app/logic/cubits/match_cubit.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isSmallScreen = screenWidth < 400;

        // Рассчитываем ширины столбцов
        final dateColumnWidth = screenWidth * (isSmallScreen ? 0.25 : 0.20);
        final opponentColumnWidth = screenWidth * (isSmallScreen ? 0.40 : 0.45);
        final resultColumnWidth = screenWidth * (isSmallScreen ? 0.35 : 0.35);

        return SingleChildScrollView(
          child: SingleChildScrollView(
            child: DataTable(
              columnSpacing: 0,
              horizontalMargin: 0,
              headingRowHeight: 40.0,
              dataRowMinHeight: 40.0,
              dataRowMaxHeight: 50.0,
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => tableHeaderColor,
              ),
              columns: [
                DataColumn(
                  label: Container(
                    width: dateColumnWidth,
                    alignment: Alignment.center,
                    child: Text('Дата'),
                  ),
                  numeric: false,
                ),
                DataColumn(
                  label: Container(
                    width: opponentColumnWidth,
                    alignment: Alignment.centerLeft,
                    child: Text('Соперник'),
                  ),
                  numeric: false,
                ),
                DataColumn(
                  label: Container(
                    width: resultColumnWidth,
                    alignment: Alignment.center,
                    child: Text(isSmallScreen ? 'Рез.' : 'Результат'),
                  ),
                  numeric: true,
                ),
              ],
              rows:
                  matches.map((match) {
                    final opponent =
                        match.firstTeamId == team.id
                            ? teamNames[match.secondTeamId]
                            : teamNames[match.firstTeamId];

                    final isWinner = team.id == match.winnerTeamId;
                    final isUpcoming = match.isUpcoming;

                    String result =
                        isUpcoming
                            ? "- : -"
                            : (team.id == match.firstTeamId)
                            ? "${match.firstTeamScore} : ${match.secondTeamScore}"
                            : "${match.secondTeamScore} : ${match.firstTeamScore}";

                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            width: dateColumnWidth,
                            alignment: Alignment.center,
                            child: Text(
                              '${match.date.day.toString().padLeft(2, '0')}.${match.date.month.toString().padLeft(2, '0')}.${match.date.year}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: opponentColumnWidth,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              opponent ?? 'Неизвестно',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: resultColumnWidth,
                            alignment: Alignment.center,
                            child: Text(
                              result,
                              style: TextStyle(
                                color:
                                    isUpcoming
                                        ? Colors.grey
                                        : isWinner
                                        ? Colors.green
                                        : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }
}
