import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/app_style.dart';
import 'package:flutter_project_andjela/common/background_container.dart';
import 'package:flutter_project_andjela/common/reusable_text.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/constants/uidata.dart';
import 'package:flutter_project_andjela/views/home/widgets/restaurant_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllNearbyRestaurants extends StatelessWidget {
  const AllNearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: kSecondary,
            title: ReusableText(
                text: "Nearby Restaurants",
                style: appStyle(13, kLightWhite, FontWeight.w600))),
        body: BackGroundContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: ListView(
              children: List.generate(restaurants.length, (i) {
                var restaurant = restaurants[i];
                return RestaurantTile(
                  restaurant: restaurant,
                );
              }),
            ),
          ),
        ));
  }
}
