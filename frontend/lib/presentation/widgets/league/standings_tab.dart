import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/standing.dart';
import 'package:yarvolley_app/logic/cubits/standing_cubit.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';

class StandingsTab extends StatelessWidget {
  const StandingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StandingCubit, StandingState>(
      builder: (context, state) {
        if (state is StandingInitial || state is StandingLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is StandingLoaded) {
          final standings = state.standings;

          return _StandingsTabView(standings: standings);
        } else if (state is StandingError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Неизвестное состояние'));
      },
    );
  }
}

class _StandingsTabView extends StatelessWidget {
  final List<Standing> standings;
  const _StandingsTabView({required this.standings});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isSmallScreen = screenWidth < 400;

        // Рассчитываем ширины столбцов
        final fixedColumnsWidth = screenWidth * (isSmallScreen ? 0.12 : 0.10);
        final teamColumnWidth = screenWidth * (isSmallScreen ? 0.30 : 0.35);
        final pointsColumnWidth = screenWidth * (isSmallScreen ? 0.12 : 0.15);

        return SingleChildScrollView(
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => tableHeaderColor,
              ),
              horizontalMargin: 0,
              headingRowHeight: 40.0,
              dataRowMinHeight: 40.0,
              dataRowMaxHeight: 50.0,
              columnSpacing: 0,
              columns: [
                DataColumn(
                  label: Container(
                    width: fixedColumnsWidth,
                    alignment: Alignment.center,
                    child: const Text('#'),
                  ),
                  numeric: true,
                  tooltip: 'Позиция в турнирной таблице',
                ),
                DataColumn(
                  label: Container(
                    width: teamColumnWidth,
                    alignment: Alignment.centerLeft,
                    child: const Text('Команда'),
                  ),
                  numeric: false,
                  tooltip: 'Название команды',
                ),
                DataColumn(
                  label: Container(
                    width: fixedColumnsWidth,
                    alignment: Alignment.center,
                    child: Text(isSmallScreen ? 'Игр' : 'Игры'),
                  ),
                  numeric: true,
                  tooltip: 'Количество сыгранных игр',
                ),
                DataColumn(
                  label: Container(
                    width: fixedColumnsWidth,
                    alignment: Alignment.center,
                    child: Text(isSmallScreen ? 'В' : 'Выигрыши'),
                  ),
                  numeric: true,
                  tooltip: 'Количество побед',
                ),
                DataColumn(
                  label: Container(
                    width: fixedColumnsWidth,
                    alignment: Alignment.center,
                    child: Text(isSmallScreen ? 'П' : 'Поражения'),
                  ),
                  numeric: true,
                  tooltip: 'Количество поражений',
                ),
                DataColumn(
                  label: Container(
                    width: pointsColumnWidth,
                    alignment: Alignment.center,
                    child: Text(isSmallScreen ? 'Очк' : 'Очки'),
                  ),
                  numeric: true,
                  tooltip: 'Количество очков',
                ),
              ],
              rows:
                  standings.asMap().entries.map((entry) {
                    final index = entry.key;
                    final standing = entry.value;
                    final position = index + 1;

                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            width: fixedColumnsWidth,
                            alignment: Alignment.center,
                            child: Text(
                              position.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: teamColumnWidth,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              standing.teamName ?? '-',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: fixedColumnsWidth,
                            alignment: Alignment.center,
                            child: Text(standing.gameAmount.toString()),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: fixedColumnsWidth,
                            alignment: Alignment.center,
                            child: Text(standing.wins.toString()),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: fixedColumnsWidth,
                            alignment: Alignment.center,
                            child: Text(standing.losses.toString()),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: pointsColumnWidth,
                            alignment: Alignment.center,
                            child: Text(
                              standing.points.toString(),
                              style: const TextStyle(
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
