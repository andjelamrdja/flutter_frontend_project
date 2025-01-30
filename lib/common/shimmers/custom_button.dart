import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/app_style.dart';
import 'package:flutter_project_andjela/common/reusable_text.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onTap,
      this.btnWidth,
      this.btnHeight,
      this.color,
      this.radius,
      required this.text});

  final void Function()? onTap;
  final double? btnWidth;
  final double? btnHeight;
  final Color? color;
  final double? radius;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnWidth ?? width,
        height: btnHeight ?? 28,
        decoration: BoxDecoration(
            color: color ?? kPrimary,
            borderRadius: BorderRadius.circular(radius ?? 9.r)),
        child: Center(
          child: ReusableText(
              text: text, style: appStyle(12, kLightWhite, FontWeight.w500)),
        ),
      ),
    );
  }
}
