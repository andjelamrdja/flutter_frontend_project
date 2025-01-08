import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/custom_appbar.dart';
import 'package:flutter_project_andjela/common/custom_container.dart';
import 'package:flutter_project_andjela/common/heading.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/views/home/widgets/category_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              CategoryList(),
              Heading(
                text: "Nearby Restaurants",
                onTap: () {},
              ),
              Heading(
                text: "Try Something New",
                onTap: () {},
              ),
              Heading(
                text: "Fastest food closer to you",
                onTap: () {},
              ),
            ],
          )),
        ));
  }
}
