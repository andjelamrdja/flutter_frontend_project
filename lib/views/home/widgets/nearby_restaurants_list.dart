import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/constants/uidata.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NearbyRestaurants extends StatelessWidget {
  const NearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 210.h,
        padding: EdgeInsets.only(left: 12.w, top: 10.h),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(restaurants.length, (i) {
            var restaurant = restaurants[i];
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(height: 200.h, width: 150.w, color: kSecondary),
            );
          }),
        ));
  }
}
