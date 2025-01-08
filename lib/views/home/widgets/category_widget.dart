import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/app_style.dart';
import 'package:flutter_project_andjela/common/reusable_text.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/controllers/category_controller.dart';
import 'package:flutter_project_andjela/views/category/all_categories.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CategoryWidget extends StatelessWidget {
  CategoryWidget({
    super.key,
    this.category,
  });

  var category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return GestureDetector(
      onTap: () {
        if (controller.categoryValue == category['_id']) {
          controller.updateCategory = '';
          controller.updateTitle = '';
        } else if (category['value'] == 'more') {
          Get.to(() => const AllCategories(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 250));
        } else {
          controller.updateCategory = category['_id'];
          controller.updateTitle = category['title'];
        }
      },
      child: Obx(() => Container(
            width: width * 0.19,
            margin: EdgeInsets.only(right: 5.w),
            padding: EdgeInsets.only(top: 4.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                    color: controller.categoryValue == category['_id']
                        ? kSecondary
                        : kOffWhite,
                    width: .5.w)),
            child: Column(
              children: [
                SizedBox(
                  height: 35.h,
                  child: Image.network(
                    category['imageUrl'], //ne ucitava mi slike
                    fit: BoxFit.contain,
                  ),
                ),
                ReusableText(
                  text: category['title'],
                  style: appStyle(12, kDark, FontWeight.normal),
                )
              ],
            ),
          )),
    );
  }
}
