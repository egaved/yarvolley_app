import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/repositories/league_repo.dart';
import 'package:yarvolley_app/data/repositories/match_repo.dart';
import 'package:yarvolley_app/data/repositories/standing_repo.dart';
import 'package:yarvolley_app/logic/cubits/league_cubit.dart';
import 'package:yarvolley_app/logic/cubits/match_cubit.dart';
import 'package:yarvolley_app/logic/cubits/standing_cubit.dart';
import 'package:yarvolley_app/presentation/widgets/league/league_details.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

class LeagueScreen extends StatelessWidget {
  const LeagueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => LeagueCubit(
                context.read<LeagueRepository>(),
                context.read<PreferencesService>(),
              )..loadFavoriteLeagues(),
        ),
        BlocProvider(
          create:
              (context) => MatchCubit(
                context.read<MatchRepository>(),
                context.read<PreferencesService>(),
              ),
        ),
        BlocProvider(
          create:
              (context) => StandingCubit(context.read<StandingRepository>()),
        ),
      ],
      child: const _LeagueScreenView(),
    );
  }
}

class _LeagueScreenView extends StatefulWidget {
  const _LeagueScreenView();

  @override
  State<_LeagueScreenView> createState() => __LeagueScreenViewState();
}

class __LeagueScreenViewState extends State<_LeagueScreenView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeagueCubit, LeagueState>(
      builder: (context, state) {
        if (state is LeagueInitial || state is LeagueLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LeagueError) {
          return Center(child: Text(state.message));
        } else if (state is LeagueLoaded) {
          return LeagueDetailsWidget(leagues: state.leagues);
        }
        return const Center(child: Text('Неизвестное состояние'));
      },
    );
  }
}
