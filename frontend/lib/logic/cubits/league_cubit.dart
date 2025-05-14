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
  final LeagueRepository repository;
  final PreferencesService preferencesService;

  LeagueCubit(this.repository, this.preferencesService)
    : super(LeagueInitial());

  Future<void> loadLeagues() async {
    emit(LeagueLoading());
    try {
      final leagues = await repository.getLeagues();
      final favoriteIds = await preferencesService.getIds('favorite_leagues');
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
        await preferencesService.removeFavoriteItem(
          'favorite_leagues',
          leagueId,
        );
      } else {
        favoriteIds.add(leagueId);
        await preferencesService.addFavoriteItem('favorite_leagues', leagueId);
      }
      emit(LeagueLoaded(state.leagues, favoriteIds));
    }
  }
}
