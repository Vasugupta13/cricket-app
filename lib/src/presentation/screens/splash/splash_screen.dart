import 'package:animate_do/animate_do.dart';
import 'package:cricket_app/src/configs/config.dart';
import 'package:cricket_app/src/constants/image_constant.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const fadeInDuration = 1500;
    return Scaffold(
      body: Center(
        child: FadeInUp(
          duration: const Duration(milliseconds: fadeInDuration),
          child: Hero(
              tag: "APP_ICON",
              child: Image.asset(
                IMAGE_CONST.APP_LOGO_TRANSPARENT,
                height: SizeConfig.defaultSize * 20,
              )),
        ),
      ),
    );
  }
}
