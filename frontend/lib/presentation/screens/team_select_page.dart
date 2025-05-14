import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/repositories/league_repo.dart';
import 'package:yarvolley_app/logic/cubits/team_select_cubit.dart';
import 'package:yarvolley_app/presentation/widgets/common_app_bar.dart';
import 'package:yarvolley_app/presentation/widgets/team/team_select_item.dart';
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
                  child: ListView.builder(
                    itemCount: state.leagues.length,
                    itemBuilder: (context, index) {
                      final league = state.leagues[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 11, top: 11),
                            child: Text(
                              league.name,
                              style: TextStyle(
                                fontFamily: 'AppCommonFont',
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          ...List.generate(league.teams.length, (i) {
                            return Column(
                              children: [
                                TeamSelectListItem(team: league.teams[i]),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.grey.shade200,
                                ),
                              ],
                            );
                          }),
                        ],
                      );
                    },
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
