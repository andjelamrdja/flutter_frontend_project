import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/shimmers/shimmer_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 10),
      height: 90.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ShimmerWidget(
                    shimmerWidth: 60.w, shimmerHieght: 50.h, shimmerRadius: 10),
              ],
            );
          }),
    );
  }
}
