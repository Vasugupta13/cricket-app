import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/src/configs/config.dart';
import 'package:cricket_app/src/constants/image_constant.dart';
import 'package:cricket_app/src/data/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerDetailScreen extends StatelessWidget {
  final PlayerDetailModel player;

  const PlayerDetailScreen({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(IMAGE_CONST.PLAYER_DETAILS_BG),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Hero(
                          tag: "player_${player.name}",
                          child: CachedNetworkImage(
                            height: SizeConfig.defaultSize * 40,
                            imageUrl: player.image,
                            placeholder: (context, path) {
                              return Image.asset(
                                  IMAGE_CONST.PLAYER_PLACEHOLDER);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.55,
                  minChildSize: 0.55,
                  maxChildSize: 0.7,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 5,
                                  width: 50,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                player.name,
                                style: GoogleFonts.passionOne(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Age: ${player.age}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Player Type: ${player.type}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Total Runs: ${player.totalRuns}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Best Performance: ${player.bestPer}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Daily Periodic Score: ${player.dps}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Yearly Periodic Score: ${player.yps}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Player Stats',
                                style: GoogleFonts.passionOne(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              CachedNetworkImage(
                                width: MediaQuery.sizeOf(context).width,
                                fit: BoxFit.cover,
                                imageUrl: player.stats,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
