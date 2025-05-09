import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/logic/cubits/match_cubit.dart';
import 'package:yarvolley_app/presentation/theme/images.dart';
import 'package:yarvolley_app/presentation/widgets/main_page_app_bar.dart';
import 'package:yarvolley_app/data/repositories/match_repo.dart';
import 'package:yarvolley_app/presentation/widgets/match_item.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => MatchCubit(
            context.read<MatchRepository>(),
            context.read<PreferencesService>(),
          )..loadFavoriteMatches(),
      child: const _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBE1FF),
      appBar: const MainPageAppBar(title: 'YARVOLLEY'),
      body: Column(
        children: [
          BlocBuilder<MatchCubit, MatchState>(
            builder: (context, state) {
              if (state is MatchInitial || state is MatchLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MatchLoaded) {
                if (state.matches.isEmpty) {
                  return const Center(child: Text('Матчи не найдены'));
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: state.matches.length,
                    itemBuilder: (context, index) {
                      final match = state.matches[index];
                      return MatchItem(
                        match: match,
                        firstTeamName: "GooD-ЯМР",
                        secondTeamName: "Команда 2",
                      );
                    },
                  ),
                );
              } else if (state is MatchError) {
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
