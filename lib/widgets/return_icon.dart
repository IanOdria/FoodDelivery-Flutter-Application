// Creates and returns an icon with an specific format

import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimentions.dart';

class ReturnIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  ReturnIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xFFF9F6EE),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: Dimentions.pixels18,
      ),
    );
  }
}
