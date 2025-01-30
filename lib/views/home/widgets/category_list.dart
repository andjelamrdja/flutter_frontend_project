import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_project_andjela/common/shimmers/categories_shimmer.dart';
import 'package:flutter_project_andjela/hooks/fetch_categories.dart';
import 'package:flutter_project_andjela/models/categories.dart';
import 'package:flutter_project_andjela/views/home/widgets/category_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryList extends HookWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCategories();
    List<CategoriesModel>? categoriesList = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;

    return isLoading
        ? const CategoriesShimmer()
        : Container(
            height: 80.h,
            padding: EdgeInsets.only(left: 12.w, top: 10.h),
            child: (categoriesList?.isNotEmpty ?? false
                ? ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(categoriesList!.length, (i) {
                      CategoriesModel category = categoriesList[i];
                      return CategoryWidget(category: category);
                    }),
                  )
                : const Center(child: Text('No categories available'))),
          );
  }
}
