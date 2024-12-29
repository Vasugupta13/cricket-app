import 'package:cricket_app/src/data/repository/auth_repo.dart';
import 'package:cricket_app/src/data/repository/player_repo.dart';
import 'package:cricket_app/src/presentation/common_blocs/auth/bloc.dart';
import 'package:cricket_app/src/presentation/common_blocs/connectivity/connectivity_bloc.dart';
import 'package:cricket_app/src/presentation/common_blocs/home/home_bloc.dart';
import 'package:cricket_app/src/presentation/screens/edit_player_details/bloc/edit_player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonBloc {
  /// Bloc
  static final authenticationBloc = AuthBloc(AuthRepository());
  static final homeBloc = HomeBloc(playerRepository: PlayerRepository());
  static final editPlayerBloc = EditPlayerBloc(playerRepository: PlayerRepository());
  static final connectivityBloc = ConnectivityBloc();

  static final List<BlocProvider> blocProviders = [

    BlocProvider<AuthBloc>(
      create: (context) => authenticationBloc,
    ),
    BlocProvider<HomeBloc>(
      create: (context) => homeBloc,
    ),
    BlocProvider<EditPlayerBloc>(
      create: (context) => editPlayerBloc,
    ),
    BlocProvider<ConnectivityBloc>(
      create: (context) => connectivityBloc,
    ),
  ];

  /// Dispose
  static void dispose() {
    authenticationBloc.close();
    homeBloc.close();
    editPlayerBloc.close();
    connectivityBloc.close();
  }

  /// Singleton factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }
  CommonBloc._internal();
}
