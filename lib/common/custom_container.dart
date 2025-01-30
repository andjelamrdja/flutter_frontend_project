import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  CustomContainer(
      {super.key,
      required this.containerContent,
      this.color,
      this.containerHeight});

  Widget containerContent;
  double? containerHeight;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight ?? MediaQuery.of(context).size.height * 0.75,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
        child: Container(
          width: width,
          color: color ?? kOffWhite,
          child: SingleChildScrollView(
            child: containerContent,
          ),
        ),
      ),
    );
  }
}
