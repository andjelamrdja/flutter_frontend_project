import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/app_style.dart';
import 'package:flutter_project_andjela/common/background_container.dart';
import 'package:flutter_project_andjela/common/reusable_text.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/constants/uidata.dart';
import 'package:flutter_project_andjela/views/home/widgets/food_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: kSecondary,
            title: ReusableText(
                text: "Recommendations",
                style: appStyle(13, kLightWhite, FontWeight.w600))),
        body: BackGroundContainer(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: ListView(
              children: List.generate(foods.length, (i) {
                var food = foods[i];
                return FoodTile(
                  food: food,
                );
              }),
            ),
          ),
        ));
  }
}
