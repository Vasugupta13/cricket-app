import 'package:cricket_app/src/constants/color_constant.dart';
import 'package:flutter/material.dart';

class PerformanceStats extends StatelessWidget {
  final String title;
  final String value;

  const PerformanceStats({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: COLOR_CONST.secondaryColor,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}