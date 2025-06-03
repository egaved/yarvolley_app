import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/league.dart';
import 'package:yarvolley_app/logic/cubits/league_cubit.dart';
import 'package:yarvolley_app/logic/cubits/match_cubit.dart';
import 'package:yarvolley_app/logic/cubits/standing_cubit.dart';
import 'package:yarvolley_app/presentation/screens/league_select_page.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';
import 'package:yarvolley_app/presentation/widgets/league/matches_tab.dart';
import 'package:yarvolley_app/presentation/widgets/league/standings_tab.dart';
import 'package:yarvolley_app/presentation/widgets/list_app_bar.dart';

class LeagueDetailsWidget extends StatefulWidget {
  final List<League> leagues;
  const LeagueDetailsWidget({super.key, required this.leagues});

  @override
  State<LeagueDetailsWidget> createState() => _LeagueDetailsWidgetState();
}

class _LeagueDetailsWidgetState extends State<LeagueDetailsWidget> {
  late League selectedLeague;

  @override
  void initState() {
    super.initState();
    if (widget.leagues.isNotEmpty) {
      selectedLeague = widget.leagues.first;
      context.read<MatchCubit>().loadLeagueMatches(selectedLeague.id);
      context.read<StandingCubit>().loadLeagueStandings(selectedLeague.id);
    } else {
      throw Exception("Нет избранных лиг");
    }
  }

  void onLeagueSelected(League league) {
    setState(() {
      selectedLeague = league;
    });
    context.read<MatchCubit>().loadLeagueMatches(selectedLeague.id);
    context.read<StandingCubit>().loadLeagueStandings(selectedLeague.id);
  }

  @override
  void didUpdateWidget(covariant LeagueDetailsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.leagues != oldWidget.leagues) {
      if (widget.leagues.isNotEmpty) {
        if (!widget.leagues.contains(selectedLeague)) {
          selectedLeague = widget.leagues.first;
        }
      } else {
        throw Exception("Нет избранных лиг");
      }
      context.read<MatchCubit>().loadLeagueMatches(selectedLeague.id);
      context.read<StandingCubit>().loadLeagueStandings(selectedLeague.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ListAppBar(
          items: widget.leagues,
          nameGetter: (league) => league.name,
          onSelected: onLeagueSelected,
          selectScreenBuilder: () => LeagueSelectScreen(),
          onSelectScreenPopped:
              () => context.read<LeagueCubit>().loadFavoriteLeagues(),
        ),
        body: Column(
          children: [
            Container(
              color: primaryColor,
              child: const TabBar(
                tabs: [Tab(text: 'Матчи'), Tab(text: 'Положение команд')],
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                enableFeedback: false,
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [MatchesTab(), StandingsTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
