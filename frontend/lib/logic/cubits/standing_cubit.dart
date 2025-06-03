import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yarvolley_app/data/domain/standing.dart';
import 'package:yarvolley_app/data/repositories/standing_repo.dart';

sealed class StandingState {}

class StandingInitial extends StandingState {}

class StandingLoading extends StandingState {}

class StandingError extends StandingState {
  final String message;
  StandingError(this.message);
}

class StandingLoaded extends StandingState {
  final List<Standing> standings;

  StandingLoaded(this.standings);
}

class StandingCubit extends Cubit<StandingState> {
  final StandingRepository _repository;

  StandingCubit(this._repository) : super(StandingInitial());

  Future<void> loadLeagueStandings(int leagueId) async {
    emit(StandingLoading());
    try {
      final standings = await _repository.getLeagueStandings(leagueId);
      emit(StandingLoaded(standings));
    } catch (e) {
      emit(StandingError('Не удалось загрузить таблицу. ${e.toString()}'));
    }
  }
}
