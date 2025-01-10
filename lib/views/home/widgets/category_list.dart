import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/constants/uidata.dart';
import 'package:flutter_project_andjela/views/home/widgets/category_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.h,
        padding: EdgeInsets.only(left: 12.w, top: 10.h),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(categories.length, (i) {
            var category = categories[i];
            return CategoryWidget(category: category);
          }),
        ));
  }
}
