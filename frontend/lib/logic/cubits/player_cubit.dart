import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/player.dart';
import 'package:yarvolley_app/data/repositories/player_repo.dart';

abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerError extends PlayerState {
  final String message;

  PlayerError(this.message);
}

class PlayerLoaded extends PlayerState {
  final List<Player> players;

  PlayerLoaded(this.players);
}

class PlayerCubit extends Cubit<PlayerState> {
  final PlayerRepository _repository;

  PlayerCubit(this._repository) : super(PlayerInitial());

  Future<void> loadTeamPlayers(int teamId) async {
    emit(PlayerLoading());
    try {
      final players = await _repository.getTeamPlayers(teamId);
      emit(PlayerLoaded(players));
    } catch (e) {
      emit(PlayerError('Не удалось загрузить игроков. ${e.toString()}'));
    }
  }
}
