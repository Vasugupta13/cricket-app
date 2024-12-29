import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/src/configs/config.dart';
import 'package:cricket_app/src/constants/color_constant.dart';
import 'package:cricket_app/src/data/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'player_stat_widget.dart';

class PlayerCard extends StatelessWidget {
  final PlayerDetailModel player;

  const PlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: COLOR_CONST.cardShadowColor,
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: SizeConfig.defaultSize * 20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [
                    COLOR_CONST.cardBackgroundColor.withOpacity(0.6),
                    COLOR_CONST.cardBackgroundColor,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "player_${player.name}",
                      child: CachedNetworkImage(
                        imageUrl: player.image,
                        placeholder: (context,path){
                          return Image.asset('assets/images/virat.png');
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              player.name.split(' ')[0],
                              style: GoogleFonts.passionOne(
                                fontSize: 25,
                                height: 1,
                                color: COLOR_CONST.backgroundColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              player.name.split(' ')[1],
                              style: GoogleFonts.passionOne(
                                fontSize: 40,
                                height: 1,
                                color: COLOR_CONST.cardTextColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize * 3,
                            ),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Age:",
                                    style: GoogleFonts.passionOne(
                                      fontSize: 20,
                                      height: 1,
                                      color: COLOR_CONST.cardTextColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    " ${player.age}",
                                    style: GoogleFonts.passionOne(
                                      fontSize: 21,
                                      height: 1,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PerformanceStats(
                      title: "Best\nPerformance",
                      value: player.bestPer,
                    ),
                    PerformanceStats(
                      title: "Total\nRuns",
                      value: player.totalRuns.toString(),
                    ),
                    PerformanceStats(
                      title: "Daily\nPeriodic score",
                      value: player.dps.toString(),
                    ),
                    PerformanceStats(
                      title: "Yearly\nPeriodic score",
                      value: player.yps.toString(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}