part of 'edit_player_bloc.dart';

@immutable
sealed class EditPlayerEvent {}
class EditPlayerDetails extends EditPlayerEvent {
  final String playerId;
  final String totalRuns;
  final String yps;
  final String dps;

  EditPlayerDetails({
    required this.playerId,
    required this.totalRuns,
    required this.yps,
    required this.dps,
  });
}