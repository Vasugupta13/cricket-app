import 'package:cricket_app/src/data/repository/player_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_player_event.dart';
part 'edit_player_state.dart';

class EditPlayerBloc extends Bloc<EditPlayerEvent, EditPlayerState> {
  final PlayerRepository playerRepository;
  EditPlayerBloc({required this.playerRepository}) : super(EditPlayerInitial()) {
    on<EditPlayerDetails>((event, emit) async {
      emit(EditPlayerDetailsLoading());
      try {
        await playerRepository.editPlayerDetails(
          event.playerId,
          event.totalRuns,
          event.yps,
          event.dps,
        );
        emit(EditPlayerDetailsSuccess());
      } catch (error) {
        emit(EditPlayerDetailsFailure(error: error.toString()));
      }
    });
  }
}
