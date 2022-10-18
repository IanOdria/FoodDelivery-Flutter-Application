// Widget que incluy nombre, reviews e iconos

import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/icon_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/utils/dimentions.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double size;
  final int stars;
  final String available;
  final int minutes;
  final double distance;
  final int comments;

  const AppColumn({
    Key? key,
    required this.text,
    required this.size,
    required this.stars,
    required this.available,
    required this.minutes,
    required this.distance,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: size,
        ),
        SizedBox(height: Dimentions.height10),
        // Estrellas y textos
        Row(
          children: [
            Wrap(
              children: List.generate(
                // List.generate en vez de brackets []
                5,
                (index) {
                  if (index < stars) {
                    return Icon(
                      Icons.star,
                      color: AppColors.mainColor,
                      size: Dimentions.pixels15,
                    );
                  } else {
                    return Icon(
                      Icons.star_border_outlined,
                      color: AppColors.mainColor,
                      size: Dimentions.pixels15,
                    );
                  }
                },
              ),
            ),
            SizedBox(width: Dimentions.pixels10),
            SmallText(text: stars.toString() + '.0'),
            SizedBox(width: Dimentions.pixels10),
            SmallText(text: comments.toString()),
            SizedBox(width: Dimentions.pixels4),
            SmallText(text: 'comments'),
          ],
        ),
        SizedBox(height: Dimentions.height15),
        // Iconos y textos
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconTextWidget(
              icon: Icons.circle_sharp,
              text: available,
              iconColor: AppColors.iconColor1,
            ),
            IconTextWidget(
              icon: Icons.location_on,
              text: distance.toString() + ' km',
              iconColor: AppColors.mainColor,
            ),
            IconTextWidget(
              icon: Icons.access_time_rounded,
              text: minutes.toString() + ' mins',
              iconColor: AppColors.iconColor2,
            )
          ],
        ),
      ],
    );
  }
}
