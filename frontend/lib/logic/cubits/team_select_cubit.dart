import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/repositories/league_repo.dart';
import 'package:yarvolley_app/data/repositories/team_repo.dart';
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
  TeamSelectLoaded(this.leagues);
}

class TeamSelectCubit extends Cubit<TeamSelectState> {
  final LeagueRepository _repository;
  final PreferencesService _preferencesService;

  TeamSelectCubit(this._repository, this._preferencesService)
    : super(TeamSelectInitial());

  Future<void> loadLeaguesWithTeams() async {
    emit(TeamSelectLoading());
    try {
      final favoriteIds = await _preferencesService.getData('favorite_leagues');
      final leagues = await _repository.getLeaguesWithTeams(
        favoriteIds.toSet(),
      );
      emit(TeamSelectLoaded(leagues));
    } catch (e) {
      emit(TeamSelectError('Не удалось загрузить лиги: $e'));
    }
  }
}
