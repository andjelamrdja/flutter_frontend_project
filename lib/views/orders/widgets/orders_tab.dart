import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/app_style.dart';
import 'package:flutter_project_andjela/common/tab_widget.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: kPrimary,
        ),
        labelColor: Colors.white,
        labelStyle: appStyle(12, kLightWhite, FontWeight.normal),
        unselectedLabelColor: kGrayLight,
        tabAlignment: TabAlignment.start,
        tabs: List.generate(
            orderList.length, (index) => TabWidget(text: orderList[index])),
      ),
    );
  }
}
