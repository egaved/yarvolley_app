import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/repositories/league_repo.dart';
import 'package:yarvolley_app/logic/cubits/league_cubit.dart';
import 'package:yarvolley_app/presentation/screens/main_page.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';
import 'package:yarvolley_app/presentation/widgets/common_app_bar.dart';
import 'package:yarvolley_app/presentation/widgets/league/league_item.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

class LeagueSelectScreen extends StatelessWidget {
  const LeagueSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => LeagueCubit(
            context.read<LeagueRepository>(),
            context.read<PreferencesService>(),
          )..loadLeagues(),
      child: _LeagueSelectScreenView(),
    );
  }
}

class _LeagueSelectScreenView extends StatelessWidget {
  const _LeagueSelectScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonPageAppBar(title: 'Выберите лиги'),
      body: Column(
        children: [
          BlocBuilder<LeagueCubit, LeagueState>(
            builder: (context, state) {
              if (state is LeagueInitial || state is LeagueLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LeagueLoaded) {
                if (state.leagues.isEmpty) {
                  return const Center(child: Text('Нет доступных лиг'));
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: state.leagues.length,
                    itemBuilder: (context, index) {
                      final league = state.leagues[index];
                      return LeagueItem(league: league);
                    },
                  ),
                );
              } else if (state is LeagueError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('Неизвестное состояние'));
            },
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<LeagueCubit, LeagueState>(
        builder: (context, state) {
          final favoriteCount =
              state is LeagueLoaded ? state.favoriteLeagueIds.length : 0;
          return Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 25),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              onPressed:
                  favoriteCount > 0
                      ? () async {
                        if (!Navigator.of(context).canPop()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      }
                      : null,
              child: const Text('Завершить'),
            ),
          );
        },
      ),
    );
  }
}
