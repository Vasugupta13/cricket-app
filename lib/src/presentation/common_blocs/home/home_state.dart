part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<PlayerDetailModel> players;

  const HomeLoaded({required this.players});

  @override
  List<Object> get props => [players];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}

class SyncLocalChangesSuccess extends HomeState {}

class SyncLocalChangesFailure extends HomeState {
  final String error;

  const SyncLocalChangesFailure({required this.error});

  @override
  List<Object> get props => [error];
}