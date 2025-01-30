import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_project_andjela/common/app_style.dart';
import 'package:flutter_project_andjela/common/background_container.dart';
import 'package:flutter_project_andjela/common/reusable_text.dart';
import 'package:flutter_project_andjela/common/shimmers/foodlist_shimmer.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/hooks/fetch_all_foods.dart';
import 'package:flutter_project_andjela/models/foods.dart';
import 'package:flutter_project_andjela/views/home/widgets/food_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Recommendations extends HookWidget {
  const Recommendations({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllFoods("41007428");
    List<FoodsModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: kSecondary,
            title: ReusableText(
                text: "Recommendations",
                style: appStyle(13, kLightWhite, FontWeight.w600))),
        body: BackGroundContainer(
          color: Colors.white,
          child: isLoading
                ? const FoodsListShimmer()
                : Padding(
            padding: EdgeInsets.all(12.h),
            child: (foods?.isNotEmpty ?? false
                    ? ListView(
                        children: List.generate(foods!.length, (i) {
                          FoodsModel food = foods[i];
                          return FoodTile(
                            food: food,
                          );
                        }),
                      )
                    : const Center(
                        child: Text('No food recommendations available'))),
          ),
        ));
  }
}
