import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/player.dart';
import 'package:yarvolley_app/data/domain/team.dart';
import 'package:yarvolley_app/logic/cubits/player_cubit.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';

class RosterTab extends StatelessWidget {
  final Team team;

  const RosterTab({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (context, state) {
        if (state is PlayerInitial || state is PlayerLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PlayerLoaded) {
          final players = state.players;

          return _RosterTabView(players: players, team: team);
        } else if (state is PlayerError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Неизвестное состояние'));
      },
    );
  }
}

class _RosterTabView extends StatelessWidget {
  final List<Player> players;
  final Team team;

  const _RosterTabView({required this.players, required this.team});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isSmallScreen = screenWidth < 400;

        // Рассчитываем ширины столбцов
        final playerColumnWidth = screenWidth * (isSmallScreen ? 0.35 : 0.40);
        final heightColumnWidth = screenWidth * (isSmallScreen ? 0.25 : 0.25);
        final birthYearColumnWidth =
            screenWidth * (isSmallScreen ? 0.40 : 0.35);

        return SingleChildScrollView(
          child: SingleChildScrollView(
            child: DataTable(
              columnSpacing: 0,
              headingRowHeight: 40.0,
              dataRowMinHeight: 40.0,
              dataRowMaxHeight: 50.0,
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => tableHeaderColor,
              ),
              columns: [
                DataColumn(
                  label: Container(
                    width: playerColumnWidth,
                    alignment: Alignment.centerLeft,
                    child: const Text('Игрок'),
                  ),
                  numeric: false,
                ),
                DataColumn(
                  label: Container(
                    width: heightColumnWidth,
                    alignment: Alignment.center,

                    child: Center(
                      child: Text(isSmallScreen ? 'Рост' : 'Рост (см.)'),
                    ),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Container(
                    width: birthYearColumnWidth,
                    alignment: Alignment.center,

                    child: Center(
                      child: Text(isSmallScreen ? 'Г.р.' : 'Год рождения'),
                    ),
                  ),
                  numeric: true,
                ),
              ],
              rows:
                  players.map((player) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            width: playerColumnWidth,
                            child: Text(
                              player.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: heightColumnWidth,
                            child: Center(
                              child: Text(player.height.toString()),
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: birthYearColumnWidth,
                            child: Center(
                              child: Text(player.birthYear.toString()),
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
