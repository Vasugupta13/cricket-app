
import 'package:cricket_app/src/data/models/player_model.dart';
import 'package:cricket_app/src/data/repository/player_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PlayerRepository playerRepository;
  HomeBloc({required this.playerRepository}) : super(HomeInitial()) {

    ///Fetch Players from firebase
    on<FetchPlayers>((event, emit) async {
      emit(HomeLoading());
      try {
        final players = await playerRepository.fetchPlayers();
        emit(HomeLoaded(players: players));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });

    ///Handles syncing operations
    on<SyncLocalChanges>((event, emit) async {
      try {
        await playerRepository.syncLocalChanges();
        add(FetchPlayers());
        emit(SyncLocalChangesSuccess());
      } catch (error) {
        emit(SyncLocalChangesFailure(error: error.toString()));
      }
    });
  }

}
