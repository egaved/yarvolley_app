import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/player.dart';
import 'package:yarvolley_app/data/domain/team.dart';
import 'package:yarvolley_app/logic/cubits/player_cubit.dart';

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
    return SingleChildScrollView(
      child: DataTable(
        headingRowHeight: 40.0,
        columns: const [
          DataColumn(label: Text('Игрок')),
          DataColumn(label: Text('Рост')),
          DataColumn(label: Text('Возраст')),
        ],
        rows:
            players.map((player) {
              final playerAge = DateTime.now;

              return DataRow(
                cells: [
                  DataCell(Text(player.name)),
                  DataCell(Text(player.height.toString())),
                  DataCell(Text(player.birthYear.toString())),
                ],
              );
            }).toList(),
      ),
    );
  }
}
