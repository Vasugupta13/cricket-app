import 'package:cricket_app/src/configs/config.dart';
import 'package:cricket_app/src/constants/color_constant.dart';
import 'package:cricket_app/src/constants/image_constant.dart';
import 'package:cricket_app/src/presentation/common_blocs/auth/auth_bloc.dart';
import 'package:cricket_app/src/presentation/common_blocs/auth/auth_event.dart';
import 'package:cricket_app/src/presentation/common_blocs/connectivity/connectivity_bloc.dart';
import 'package:cricket_app/src/presentation/common_blocs/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/player_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(FetchPlayers());
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
            const Text(
              "Cricket App",
              style: TextStyle(
                color: COLOR_CONST.textColor,
                fontWeight: FontWeight.w600,
              ),
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
      body: BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, state) {
          if (state is ConnectivityFailure) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IMAGE_CONST.NO_INTERNET_PNG,
                  height: SizeConfig.screenHeight * 0.3,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                const Text(
                  "No Internet Connection !",
                  style: TextStyle(
                      color: COLOR_CONST.secondaryColor, fontSize: 14),
                )
              ],
            ));
          } else {
            return Column(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                    AppRouter.PLAYER_DETAILS_SCREEN,
                                    arguments: player,
                                  );
                                },
                                child: PlayerCard(player: player));
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
            );
          }
        },
      ),
    );
  }
}
