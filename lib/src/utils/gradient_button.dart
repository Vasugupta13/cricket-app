import 'package:cricket_app/src/constants/color_constant.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final double fontSize;
  final double? borderRadius;
  const GradientButton({super.key, required this.title, this.onTap, this.fontSize = 16, this.borderRadius = 10});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              COLOR_CONST.primaryColor,
              COLOR_CONST.primaryColor.withOpacity(0.5),
              COLOR_CONST.primaryColor,
            ],
            stops: const [
              0.0,
              0.4,
              1.0,
            ],
          ),
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize:fontSize ,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
