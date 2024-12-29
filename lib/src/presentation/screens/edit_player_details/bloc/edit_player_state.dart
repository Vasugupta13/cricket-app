part of 'edit_player_bloc.dart';

@immutable
sealed class EditPlayerState {}

final class EditPlayerInitial extends EditPlayerState {}

class EditPlayerDetailsLoading extends EditPlayerState {}

class EditPlayerDetailsSuccess extends EditPlayerState {}

class EditPlayerDetailsFailure extends EditPlayerState {
  final String error;

  EditPlayerDetailsFailure({required this.error});
}