import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/match.dart';
import 'package:yarvolley_app/data/repositories/match_repo.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

abstract class MatchState {}

class MatchInitial extends MatchState {}

class MatchLoading extends MatchState {}

class MatchLoaded extends MatchState {
  final List<Match> matches;

  MatchLoaded(this.matches);
}

class MatchError extends MatchState {
  final String message;
  MatchError(this.message);
}

class MatchCubit extends Cubit<MatchState> {
  final MatchRepository repository;
  final PreferencesService preferencesService;

  MatchCubit(this.repository, this.preferencesService) : super(MatchInitial());

  Future<void> loadFavoriteMatches() async {
    final favoriteLeagues = await preferencesService.getFavoriteLeagueIds();
    await _loadMatchesForHomePage(favoriteLeagues);
  }

  Future<void> loadTeamMatches(int teamId) async {
    emit(MatchLoading());

    try {
      final matches = await repository.getTeamMatches(teamId.toString());
      emit(MatchLoaded(matches));
    } catch (e) {
      emit(MatchError('Не удалось загрузить матчи.'));
    }
  }

  Future<void> _loadMatchesForHomePage(List<int> leagueIds) async {
    emit(MatchLoading());
    try {
      final List<Future<List<Match>>> futures =
          leagueIds
              .map((leagueId) => repository.getLeagueMatches(leagueId))
              .toList();
      final List<List<Match>> matchesList = await Future.wait(futures);
      final List<Match> allMatches =
          matchesList.expand((matches) => matches).toList();

      emit(MatchLoaded(allMatches));
    } catch (e) {
      print(e.toString());
      emit(MatchError('Не удалось загрузить матчи.'));
    }
  }
}
