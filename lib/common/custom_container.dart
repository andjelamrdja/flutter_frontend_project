import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  CustomContainer({super.key, required this.containerContent});

  Widget containerContent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: width,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r)),
          child: Container(
              width: width,
              color: kOffWhite,
              child: SingleChildScrollView(
                child: containerContent,
              ))),
    );
  }
}
