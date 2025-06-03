import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/repositories/league_repo.dart';
import 'package:yarvolley_app/presentation/dto/league_dto.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

sealed class TeamSelectState {}

class TeamSelectInitial extends TeamSelectState {}

class TeamSelectLoading extends TeamSelectState {}

class TeamSelectError extends TeamSelectState {
  final String message;

  TeamSelectError(this.message);
}

class TeamSelectLoaded extends TeamSelectState {
  final List<LeagueDisplay> leagues;
  final Set<int> favoriteTeamIds;
  TeamSelectLoaded(this.leagues, this.favoriteTeamIds);
}

class TeamSelectCubit extends Cubit<TeamSelectState> {
  final LeagueRepository _repository;
  final PreferencesService _preferencesService;

  TeamSelectCubit(this._repository, this._preferencesService)
    : super(TeamSelectInitial());

  Future<void> loadLeaguesWithTeams() async {
    emit(TeamSelectLoading());
    try {
      final favoriteLeagueIds = await _preferencesService.getIds(
        'favorite_leagues',
      );
      final leagues = await _repository.getLeaguesWithTeams(
        favoriteLeagueIds.toSet(),
      );
      final favoriteTeamIds = await _preferencesService.getIds(
        'favorite_teams',
      );
      emit(TeamSelectLoaded(leagues, favoriteTeamIds.toSet()));
    } catch (e) {
      emit(TeamSelectError('Не удалось загрузить лиги: $e'));
    }
  }

  Future<void> toggleFavorite(int teamId) async {
    final state = this.state;
    if (state is TeamSelectLoaded) {
      final ids = Set<int>.from(state.favoriteTeamIds);
      if (ids.contains(teamId)) {
        ids.remove(teamId);
        await _preferencesService.removeFavoriteItem('favorite_teams', teamId);
      } else {
        ids.add(teamId);
        await _preferencesService.addFavoriteItem('favorite_teams', teamId);
      }
      emit(TeamSelectLoaded(state.leagues, ids));
    }
  }
}
