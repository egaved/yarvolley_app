import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/team.dart';
import 'package:yarvolley_app/data/repositories/team_repo.dart';
import 'package:yarvolley_app/services/preferences_service.dart';

sealed class TeamState {}

class TeamInitial extends TeamState {}

class TeamLoading extends TeamState {}

class NoChoosenTeams extends TeamState {
  final String message;
  NoChoosenTeams(this.message);
}

class TeamLoaded extends TeamState {
  final List<Team> teams;
  final Set<int> favoriteTeamIds;

  TeamLoaded(this.teams, this.favoriteTeamIds);
}

class TeamError extends TeamState {
  final String message;

  TeamError(this.message);
}

class TeamCubit extends Cubit<TeamState> {
  final TeamRepository _repository;
  final PreferencesService _preferencesService;

  TeamCubit(this._repository, this._preferencesService) : super(TeamInitial());

  Future<void> loadFavoriteTeams() async {
    final favoriteTeamsIds = await _preferencesService.getIds('favorite_teams');

    emit(TeamLoading());
    try {
      final List<Future<Team>> futures =
          favoriteTeamsIds
              .map((teamId) => _repository.getTeamById(teamId))
              .toList();
      final List<Team> teamList = await Future.wait(futures);
      if (teamList.isEmpty) {
        emit(NoChoosenTeams('Вы еще не добавили в избранное ни одной команды'));
      } else {
        emit(TeamLoaded(teamList, favoriteTeamsIds.toSet()));
      }
    } catch (e) {
      emit(TeamError('Не удалось загрузить команды.'));
    }
  }

  Future<void> toggleFavorite(int teamId) async {
    final state = this.state;

    if (state is TeamLoaded) {
      final favoriteIds = Set<int>.from(state.favoriteTeamIds);
      if (favoriteIds.contains(teamId)) {
        favoriteIds.remove(teamId);
        await _preferencesService.removeFavoriteItem('favorite_teams', teamId);
      } else {
        favoriteIds.add(teamId);
        await _preferencesService.addFavoriteItem('favorite_teams', teamId);
      }
      emit(TeamLoaded(state.teams, favoriteIds));
    }
  }
}
