import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/repositories/match_repo.dart';
import 'package:yarvolley_app/data/repositories/player_repo.dart';
import 'package:yarvolley_app/data/repositories/team_repo.dart';
import 'package:yarvolley_app/logic/cubits/match_cubit.dart';
import 'package:yarvolley_app/logic/cubits/player_cubit.dart';
import 'package:yarvolley_app/logic/cubits/team_cubit.dart';
import 'package:yarvolley_app/presentation/screens/team_select_page.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';
import 'package:yarvolley_app/presentation/widgets/common_app_bar.dart';
import 'package:yarvolley_app/presentation/widgets/team/team_details.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => TeamCubit(
                context.read<TeamRepository>(),
                context.read<PreferencesService>(),
              )..loadFavoriteTeams(),
        ),
        BlocProvider(
          create:
              (context) => MatchCubit(
                context.read<MatchRepository>(),
                context.read<PreferencesService>(),
              ),
        ),
        BlocProvider(
          create: (context) => PlayerCubit(context.read<PlayerRepository>()),
        ),
      ],
      child: const _TeamScreenView(),
    );
  }
}

class _TeamScreenView extends StatefulWidget {
  const _TeamScreenView();

  @override
  State<_TeamScreenView> createState() => _TeamScreenViewState();
}

class _TeamScreenViewState extends State<_TeamScreenView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamCubit, TeamState>(
      builder: (context, state) {
        if (state is TeamInitial || state is TeamLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NoChoosenTeams) {
          return NoTeamsWidget(message: state.message);
        } else if (state is TeamError) {
          return Center(child: Text(state.message));
        } else if (state is TeamLoaded) {
          return TeamDetailsWidget(
            teams: state.teams,
            unsubButtonAction: () {
              context.read<TeamCubit>().toggleFavorite;
            },
          );
        }
        return const Center(child: Text('Неизвестное состояние'));
      },
    );
  }
}

class NoTeamsWidget extends StatelessWidget {
  final String message;
  const NoTeamsWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonPageAppBar(title: 'Команды'),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(fontFamily: 'AppLogoFont', fontSize: 16),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(left: 100, right: 100),
                backgroundColor: secondaryColor,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontFamily: 'AppLogoFont', fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeamSelectScreen(),
                  ),
                ).then((_) {
                  context.read<TeamCubit>().loadFavoriteTeams();
                });
              },
              child: const Text('Выбрать'),
            ),
          ],
        ),
      ),
    );
  }
}
