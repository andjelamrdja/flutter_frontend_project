// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/shimmers/custom_button.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/models/restaurants.dart';
import 'package:flutter_project_andjela/views/restaurant/rating_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RestaurantBottomBar extends StatelessWidget {
  const RestaurantBottomBar({
    super.key,
    required this.restaurant,
  });

  final RestaurantsModel? restaurant;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RatingBarIndicator(
          itemCount: 5,
          itemSize: 25,
          rating: restaurant!.rating.toDouble(),
          itemBuilder: (context, i) =>
              const Icon(Icons.star, color: Colors.yellow),
        ),
        CustomButton(
            onTap: () {
              Get.to(() => const RatingPage());
            },
            color: kSecondary,
            btnWidth: width / 3,
            text: "Rate Restaurant")
      ],
    );
  }
}
