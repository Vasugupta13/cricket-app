import 'package:cricket_app/src/app_view.dart';
import 'package:cricket_app/src/configs/config.dart';
import 'package:cricket_app/src/constants/color_constant.dart';
import 'package:cricket_app/src/constants/image_constant.dart';
import 'package:cricket_app/src/presentation/common_blocs/auth/bloc.dart';
import 'package:cricket_app/src/presentation/common_blocs/connectivity/connectivity_bloc.dart';
import 'package:cricket_app/src/presentation/common_blocs/home/home_bloc.dart';
import 'package:cricket_app/src/presentation/screens/creator_home/widgets/player_card_widget.dart';
import 'package:cricket_app/src/utils/snackbars_and_toasts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatorHomeScreen extends StatefulWidget {
  const CreatorHomeScreen({super.key});

  @override
  State<CreatorHomeScreen> createState() => _CreatorHomeScreenState();
}

class _CreatorHomeScreenState extends State<CreatorHomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  void _showNoInternetSnackbar() {
    context.read<HomeBloc>().add(FetchPlayers());
    SnackbarsAndToasts.showErrorSnackbar(navigatorContext!, 'No internet connection');
  }

  void _hideNoInternetSnackbar() {
    context.read<HomeBloc>().add(SyncLocalChanges());
    ScaffoldMessenger.of(navigatorContext!).hideCurrentSnackBar();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Row(
          children: [
            Hero(
              tag: "APP_ICON",
              child: Image.asset(
                IMAGE_CONST.APP_LOGO_TRANSPARENT,
                height: SizeConfig.defaultSize * 5,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cricket App",
                  style: TextStyle(
                    color: COLOR_CONST.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Operator",
                  style: TextStyle(
                      color: COLOR_CONST.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
              onTap: () {
                context.read<AuthBloc>().add(SignOutEvent());
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.logout_rounded),
              ))
        ],
      ),
      backgroundColor: COLOR_CONST.backgroundColor,
      body: BlocListener<ConnectivityBloc, ConnectivityState>(
        listener: (context, state) {
          if (state is ConnectivitySuccess) {
            _hideNoInternetSnackbar();
          }else if (state is ConnectivityFailure){
            _showNoInternetSnackbar();
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.SEARCH_SCREEN);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(81),
                    color: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.search),
                        Text("   Search for players....")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeLoaded) {
                    return ListView.builder(
                      itemCount: state.players.length,
                      itemBuilder: (context, index) {
                        final player = state.players[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRouter.EDIT_PLAYER_DETAILS_SCREEN,
                                arguments: player,
                              );
                            },
                            child: CreatorPlayerCard(player: player));
                      },
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('No players found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
