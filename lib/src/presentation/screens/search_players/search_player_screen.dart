import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/src/configs/config.dart';
import 'package:cricket_app/src/constants/color_constant.dart';
import 'package:cricket_app/src/data/models/player_model.dart';
import 'package:cricket_app/src/presentation/common_blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPlayerScreen extends StatefulWidget {
  const SearchPlayerScreen({super.key});

  @override
  State<SearchPlayerScreen> createState() => _SearchPlayerScreenState();
}

class _SearchPlayerScreenState extends State<SearchPlayerScreen> {
  final TextEditingController searchController = TextEditingController();
  List<PlayerDetailModel> filteredPlayers = [];

  void onSearch() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      final homeState = context.read<HomeBloc>().state;
      if (homeState is HomeLoaded) {
        setState(() {
          filteredPlayers = homeState.players
              .where((player) => player.name.toLowerCase().contains(query))
              .toList();
        });
      }
    } else {
      setState(() {
        filteredPlayers = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Players'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for players...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: onSearch,
                ),
              ),
              //onSubmitted: (_) => onSearch(),
              onChanged: (_) => onSearch(),
            ),
          ),
          Expanded(
            child: filteredPlayers.isEmpty
                ? const Center(child: Text('No players found'))
                : ListView.builder(
                    itemCount: filteredPlayers.length,
                    itemBuilder: (context, index) {
                      final player = filteredPlayers[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.PLAYER_DETAILS_SCREEN,
                            arguments: player,
                          );
                        },
                        child: ListTile(
                          leading: Container(
                              width: SizeConfig.screenWidth * 0.17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                  colors: [
                                    COLOR_CONST.cardBackgroundColor
                                        .withOpacity(0.6),
                                    COLOR_CONST.cardBackgroundColor,
                                    COLOR_CONST.cardBackgroundColor
                                        .withOpacity(0.6),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Hero(
                                  tag: "player_${player.name}",
                                  child: CachedNetworkImage(
                                    imageUrl: player.image,
                                  ),
                                ),
                              )),
                          title: Text(
                            player.name,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: COLOR_CONST.textColor),
                          ),
                          subtitle: Text(
                            'Age: ${player.age}',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: COLOR_CONST.textColor),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
