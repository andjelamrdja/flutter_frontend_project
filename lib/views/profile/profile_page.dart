import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/custom_container.dart';
import 'package:flutter_project_andjela/common/profile_app_bar.dart';
import 'package:flutter_project_andjela/common/shimmers/custom_button.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/controllers/login_controller.dart';
import 'package:flutter_project_andjela/models/login_response.dart';
import 'package:flutter_project_andjela/views/auth/login_redirect.dart';
import 'package:flutter_project_andjela/views/auth/verification_page.dart';
import 'package:flutter_project_andjela/views/profile/widgets/profile_tile_widget.dart';
import 'package:flutter_project_andjela/views/profile/widgets/user_info_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;
    final controller = Get.put(LoginController());

    final box = GetStorage();

    String? token = box.read('token');

    if (token != null) {
      user = controller.getUserInfo();
    }

    if (token == null) {
      return const LoginRedirect();
    }

    if (user != null && user.verification == false) {
      return const VerificationPage();
    }

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.h), child: const ProfileAppBar()),
      body: SafeArea(
        child: CustomContainer(
          containerContent: Column(
            children: [
              UserInfoWidget(user: user),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 220.h, //220
                decoration: const BoxDecoration(
                  color: kLightWhite,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                        onTap: () {},
                        title: "My Orders",
                        icon: Ionicons.fast_food_outline),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "My favourite places",
                        icon: Ionicons.heart_outline),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "Reviews",
                        icon: Ionicons.chatbubbles_outline),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "Coupons",
                        icon: MaterialCommunityIcons.tag_outline),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                height: 220.h, //220
                decoration: const BoxDecoration(
                  color: kLightWhite,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                        onTap: () {
                          Get.to(() => const LoginRedirect());
                        },
                        title: "Shipping Address",
                        icon: SimpleLineIcons.location_pin),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "Service Centeer",
                        icon: AntDesign.customerservice),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "App Feedback",
                        icon: MaterialIcons.rss_feed),
                    ProfileTileWidget(
                        onTap: () {},
                        title: "Settings",
                        icon: AntDesign.setting),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onTap: () {
                  controller.logout();
                },
                color: kRed,
                text: "Logout",
                radius: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
