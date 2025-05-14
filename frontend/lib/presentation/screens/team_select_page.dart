import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/repositories/league_repo.dart';
import 'package:yarvolley_app/logic/cubits/team_select_cubit.dart';
import 'package:yarvolley_app/presentation/widgets/common_app_bar.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

class TeamSelectScreen extends StatelessWidget {
  const TeamSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => TeamSelectCubit(
            context.read<LeagueRepository>(),
            context.read<PreferencesService>(),
          )..loadLeaguesWithTeams(),
      child: const _TeamSelectScreenView(),
    );
  }
}

class _TeamSelectScreenView extends StatelessWidget {
  const _TeamSelectScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonPageAppBar(title: 'Выберите команды'),
      body: Column(
        children: [
          BlocBuilder<TeamSelectCubit, TeamSelectState>(
            builder: (context, state) {
              if (state is TeamSelectInitial || state is TeamSelectLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TeamSelectLoaded) {
                return Expanded(
                  child: ListView(
                    children:
                        state.leagues.expand((league) {
                          return [
                            Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                league.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ...league.teams.map(
                              (team) => Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(team.name),
                              ),
                            ),
                          ];
                        }).toList(),
                  ),
                );
              } else if (state is TeamSelectError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('Неизвестное состояние'));
            },
          ),
        ],
      ),
    );
  }
}
