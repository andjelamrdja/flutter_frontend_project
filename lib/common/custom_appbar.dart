import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/app_style.dart';
import 'package:flutter_project_andjela/common/reusable_text.dart';
import 'package:flutter_project_andjela/controllers/user_location_controller.dart';
import 'package:flutter_project_andjela/hooks/fetch_default.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? accessToken = box.read('token');
    if (accessToken != null) {
      useFetchDefault();
    }
    final controller = Get.put(UserLocationController());
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        height: 80.h, //bilo je 110.h
        width: width,
        color: kOffWhite,
        child: Container(
            margin: EdgeInsets.only(top: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, //tamo je end
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center, //tamo je end
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor: kSecondary,
                      backgroundImage:
                          const AssetImage('assets/images/profile.jpg'),
                      //backgroundImage: CachedNetworkImageProvider(
                      // 'https://d326fntlu7tb1e.cloudfront.net/uploads/bdec9d7d-0544-4fc4-823d-3b898f6dbbbf-vinci_03.jpeg',
                      // ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                              text: "Deliver to",
                              style: appStyle(13, kSecondary, FontWeight.w600)),
                          Obx(
                            () => SizedBox(
                              width: width * 0.65,
                              child: Text(
                                  controller.address1 == ""
                                      ? controller.address == ''
                                          ? "Please enable location services to get your address"
                                          : controller.address
                                      : controller.address1,
                                  overflow: TextOverflow.ellipsis,
                                  style: appStyle(
                                      11, kGrayLight, FontWeight.normal)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Text(getTimeOfDay(),
                    style: const TextStyle(fontSize: 30)), //tamo je 35
              ],
            )));
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return ' ☀️ ';
    } else if (hour >= 12 && hour < 16) {
      return ' ⛅ ';
    } else {
      return ' 🌙 ';
    }
  }
}
