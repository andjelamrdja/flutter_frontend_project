import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/custom_appbar.dart';
import 'package:flutter_project_andjela/common/custom_container.dart';
import 'package:flutter_project_andjela/common/heading.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/views/home/all_fastest_food.dart';
import 'package:flutter_project_andjela/views/home/all_nearby_restaurants.dart';
import 'package:flutter_project_andjela/views/home/recommendations_page.dart';
import 'package:flutter_project_andjela/views/home/widgets/category_list.dart';
import 'package:flutter_project_andjela/views/home/widgets/food_list.dart';
import 'package:flutter_project_andjela/views/home/widgets/nearby_restaurants_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(130.h), child: const CustomAppBar()),
        body: SafeArea(
          child: CustomContainer(
              containerContent: Column(
            children: [
              const CategoryList(),
              Heading(
                text: "Nearby Restaurants",
                onTap: () {
                  Get.to(() => const AllNearbyRestaurants(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 250));
                },
              ),
              const NearbyRestaurants(),
              Heading(
                text: "Try Something New",
                onTap: () {
                  Get.to(() => const Recommendations(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 250));
                },
              ),
              const FoodsList(),
              Heading(
                text: "Fastest food closer to you",
                onTap: () {
                  Get.to(() => const AllFastestFood(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 250));
                },
              ),
              const FoodsList(),
            ],
          )),
        ));
  }
}
