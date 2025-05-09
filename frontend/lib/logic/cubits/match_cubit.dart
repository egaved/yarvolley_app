import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/match.dart';
import 'package:yarvolley_app/data/repositories/match_repo.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

abstract class MatchState {}

class MatchInitial extends MatchState {}

class MatchLoading extends MatchState {}

class MatchLoaded extends MatchState {
  final List<Match> matches;
  final Map<int, String> teamNames;

  MatchLoaded(this.matches, this.teamNames);
}

class MatchError extends MatchState {
  final String message;
  MatchError(this.message);
}

class MatchCubit extends Cubit<MatchState> {
  final MatchRepository _repository;
  final PreferencesService _preferencesService;

  MatchCubit(this._repository, this._preferencesService)
    : super(MatchInitial());

  Future<Map<int, String>> _loadTeamNames(List<Match> matches) async {
    Set<int> teamIds =
        matches
            .expand((match) => [match.firstTeamId, match.secondTeamId])
            .toSet();
    final teamNames = await _repository.getTeamNames(teamIds);
    return teamNames;
  }

  Future<void> loadFavoriteMatches() async {
    final favoriteLeagues = await _preferencesService.getFavoriteLeagueIds();
    await _loadMatchesForHomePage(favoriteLeagues);
  }

  Future<void> loadTeamMatches(int teamId) async {
    emit(MatchLoading());

    try {
      final matches = await _repository.getTeamMatches(teamId.toString());
      final teamNames = await _loadTeamNames(matches);
      emit(MatchLoaded(matches, teamNames));
    } catch (e) {
      emit(MatchError('Не удалось загрузить матчи.'));
    }
  }

  Future<void> _loadMatchesForHomePage(List<int> leagueIds) async {
    emit(MatchLoading());
    try {
      final List<Future<List<Match>>> futures =
          leagueIds
              .map((leagueId) => _repository.getLeagueMatches(leagueId))
              .toList();
      final List<List<Match>> matchesList = await Future.wait(futures);
      final List<Match> allMatches =
          matchesList.expand((matches) => matches).toList();
      final teamNames = await _loadTeamNames(allMatches);
      emit(MatchLoaded(allMatches, teamNames));
    } catch (e) {
      print(e.toString());
      emit(MatchError('Не удалось загрузить матчи.'));
    }
  }
}
