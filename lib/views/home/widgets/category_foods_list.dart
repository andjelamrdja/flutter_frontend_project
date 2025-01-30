import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_project_andjela/common/shimmers/foodlist_shimmer.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/hooks/fetch_category_foods.dart';
import 'package:flutter_project_andjela/models/foods.dart';
import 'package:flutter_project_andjela/views/home/widgets/food_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryFoodsList extends HookWidget {
  const CategoryFoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchFoodsByCategory("41007428");
    final isLoading = hookResult.isLoading;
    List<FoodsModel>? foods = hookResult.data;
    return SizedBox(
        width: width,
        height: height,
        child: isLoading
            ? const FoodsListShimmer()
            : Padding(
                padding: EdgeInsets.all(12.h),
                child: (foods?.isNotEmpty ?? false
                    ? ListView(
                        children: List.generate(foods!.length, (i) {
                          FoodsModel food = foods[i];
                          return FoodTile(
                            color: Colors.white,
                            food: food,
                          );
                        }),
                      )
                    : const Center(
                        child: Text('No food close to you available'))),
              ));
  }
}
