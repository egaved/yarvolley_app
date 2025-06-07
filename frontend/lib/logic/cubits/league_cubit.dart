import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/league.dart';
import 'package:yarvolley_app/data/repositories/league_repo.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

abstract class LeagueState {}

class LeagueInitial extends LeagueState {}

class LeagueLoading extends LeagueState {}

class LeagueLoaded extends LeagueState {
  final List<League> leagues;
  final Set<int> favoriteLeagueIds;
  LeagueLoaded(this.leagues, this.favoriteLeagueIds);
}

class LeagueError extends LeagueState {
  final String message;
  LeagueError(this.message);
}

class LeagueCubit extends Cubit<LeagueState> {
  final LeagueRepository _repository;
  final PreferencesService _preferencesService;

  LeagueCubit(this._repository, this._preferencesService)
    : super(LeagueInitial());

  Future<void> loadLeagues() async {
    emit(LeagueLoading());
    try {
      final leagues = await _repository.getLeagues();
      final favoriteIds = await _preferencesService.getIds('favorite_leagues');
      emit(LeagueLoaded(leagues, favoriteIds.toSet()));
    } catch (e) {
      emit(LeagueError('Не удалось загрузить лиги'));
    }
  }

  Future<void> toggleFavorite(int leagueId) async {
    final state = this.state;
    if (state is LeagueLoaded) {
      final favoriteIds = Set<int>.from(state.favoriteLeagueIds);
      if (favoriteIds.contains(leagueId)) {
        favoriteIds.remove(leagueId);
        await _preferencesService.removeFavoriteItem(
          'favorite_leagues',
          leagueId,
        );
      } else {
        favoriteIds.add(leagueId);
        await _preferencesService.addFavoriteItem('favorite_leagues', leagueId);
      }
      emit(LeagueLoaded(state.leagues, favoriteIds));
    }
  }

  Future<void> loadFavoriteLeagues() async {
    final favoriteLeagueIds = await _preferencesService.getIds(
      'favorite_leagues',
    );
    emit(LeagueLoading());
    try {
      final List<Future<League>> futures =
          favoriteLeagueIds.map((id) => _repository.getLeagueById(id)).toList();
      final leagueList = await Future.wait(futures);
      emit(LeagueLoaded(leagueList, favoriteLeagueIds.toSet()));
    } catch (e) {
      emit(LeagueError('Не удалось загрузить лиги.'));
    }
  }
}
