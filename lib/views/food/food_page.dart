// ignore_for_file: unrelated_type_equality_checks

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_project_andjela/common/app_style.dart';
import 'package:flutter_project_andjela/common/custom_text_field.dart';
import 'package:flutter_project_andjela/common/reusable_text.dart';
import 'package:flutter_project_andjela/common/shimmers/custom_button.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/controllers/cart_controller.dart';
import 'package:flutter_project_andjela/controllers/foods_controller.dart';
import 'package:flutter_project_andjela/controllers/login_controller.dart';
import 'package:flutter_project_andjela/hooks/fetch_default.dart';
import 'package:flutter_project_andjela/hooks/fetch_restaurant.dart';
import 'package:flutter_project_andjela/models/address_model.dart';
import 'package:flutter_project_andjela/models/adresses_response.dart';
import 'package:flutter_project_andjela/models/cart_request.dart';
import 'package:flutter_project_andjela/models/foods.dart';
import 'package:flutter_project_andjela/models/login_response.dart';
import 'package:flutter_project_andjela/models/order_request.dart';
import 'package:flutter_project_andjela/models/restaurants.dart';
import 'package:flutter_project_andjela/views/auth/login_page.dart';
import 'package:flutter_project_andjela/views/orders/order_page.dart';
import 'package:flutter_project_andjela/views/profile/shipping_address.dart';
import 'package:flutter_project_andjela/views/restaurant/restaurant_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class FoodPage extends StatefulHookWidget {
  const FoodPage({super.key, required this.food});

  final FoodsModel food;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final PageController _pageController = PageController();
  final TextEditingController _preferences = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    LoginResponse? user;
    final loginController = Get.put(LoginController());
    user = loginController.getUserInfo();
    final controller = Get.put(FoodController());
    final hookResult = useFetchRestaurant(widget.food.restaurant);
    final data = useFetchDefault();
    AddressResponse? address = data.data;
    RestaurantsModel? restaurant = hookResult.data;
    controller.loadAdditives(widget.food.additives);

    return address == null
        ? const ShippingAddress()
        : Scaffold(
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.r),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 230.h,
                        child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              controller.changePage(index);
                            },
                            itemCount: widget.food.imageUrl.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: width,
                                height: 230.h,
                                color: kLightWhite,
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: widget.food.imageUrl[index]),
                              );
                            }),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  widget.food.imageUrl.length, (index) {
                                return Container(
                                  margin: EdgeInsets.all(4.h),
                                  width: 10.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.currentPage == index
                                        ? kSecondary
                                        : kGrayLight,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.h,
                        left: 12.w,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Ionicons.chevron_back_circle,
                            color: kPrimary,
                            size: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.h,
                        right: 12.w,
                        child: CustomButton(
                          onTap: () {
                            Get.to(() =>
                                RestaurantPage(restaurant: hookResult.data));
                          },
                          btnWidth: 120.w,
                          text: "Open Restaurant",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                              text: widget.food.title,
                              style: appStyle(18, kDark, FontWeight.w600)),
                          Obx(
                            () => ReusableText(
                                text:
                                    "\$ ${((widget.food.price + controller.additivePrice) * controller.count.value)}",
                                style: appStyle(18, kPrimary, FontWeight.w600)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        widget.food.description,
                        textAlign: TextAlign.justify,
                        maxLines: 8,
                        style: appStyle(12, kGray, FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 18.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(widget.food.foodTags.length,
                              (index) {
                            final tag = widget.food.foodTags[index];
                            return Container(
                              margin: EdgeInsets.only(right: 5.w),
                              decoration: BoxDecoration(
                                color: kPrimary,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: ReusableText(
                                    text: tag,
                                    style:
                                        appStyle(11, kWhite, FontWeight.w400)),
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      ReusableText(
                          text: "Additives and Toppings",
                          style: appStyle(18, kDark, FontWeight.w600)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Obx(
                        () => Column(
                          children: List.generate(
                              controller.additivesList.length, (index) {
                            final additive = controller.additivesList[index];
                            return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                dense: true,
                                activeColor: kSecondary,
                                value: additive.isChecked.value,
                                tristate: false,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableText(
                                        text: additive.title,
                                        style: appStyle(
                                            12, kDark, FontWeight.w400)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ReusableText(
                                        text: "\$ ${additive.price}",
                                        style: appStyle(
                                            12, kPrimary, FontWeight.w600)),
                                  ],
                                ),
                                onChanged: (bool? value) {
                                  additive.toggleChecked();
                                  controller.getTotalPrice();
                                  controller.getCartAdditive();
                                });
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                              text: "Quantity",
                              style: appStyle(18, kDark, FontWeight.w600)),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.decrement();
                                },
                                child: const Icon(AntDesign.minuscircleo),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Obx(
                                  () => ReusableText(
                                      text: "${controller.count.value}",
                                      style:
                                          appStyle(14, kDark, FontWeight.w600)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.increment();
                                },
                                child: const Icon(AntDesign.pluscircleo),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ReusableText(
                          text: "Preferences",
                          style: appStyle(18, kDark, FontWeight.w600)),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 65.h,
                        child: CustomTextWidget(
                          controller: _preferences,
                          hintText: "Add a note with your preferences",
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (user == null) {
                                  Get.to(() => const LoginPage());
                                } else {
                                  double price = (widget.food.price +
                                          controller.additivePrice) *
                                      controller.count.value;
                                  OrderItem item = OrderItem(
                                      foodId: widget.food.id,
                                      quantity: controller.count.value,
                                      price: price,
                                      additives: controller.getCartAdditive(),
                                      instructions: _preferences.text);

                                  Get.to(
                                      () => OrderPage(
                                            restaurant: restaurant,
                                            food: widget.food,
                                            item: item,
                                          ),
                                      transition: Transition.cupertino,
                                      duration:
                                          const Duration(milliseconds: 500));
                                }

                                //OVO KORISTIM KAD OMOGUCIM VERIFIKACIJU TELEFONA

                                //   if(user == null){
                                //   Get.to(()=> const LoginPage());
                                // } else if (user.phoneVerification == false){
                                //   //showVerificationSheet(context);
                                // } else {
                                //   Get.to(()=> const OrderPage());
                                // }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: ReusableText(
                                    text: "Place Order",
                                    style: appStyle(
                                        18, kLightWhite, FontWeight.w500)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                double price = (widget.food.price +
                                        controller.additivePrice) *
                                    controller.count.value;

                                var data = CartRequest(
                                    productId: widget.food.id,
                                    additives: controller.getCartAdditive(),
                                    quantity: controller.count.value,
                                    totalPrice: price);

                                String cart = cartRequestToJson(data);

                                cartController.addToCart(cart);
                              },
                              child: CircleAvatar(
                                backgroundColor: kSecondary,
                                radius: 20.r,
                                child: const Icon(
                                  Ionicons.cart,
                                  color: kLightWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Future<dynamic> showVerificationSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        showDragHandle: true,
        builder: (BuildContext context) {
          return Container(
            height: 800, //500
            width: width,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/images/restaurant_bk.png"),
                  fit: BoxFit.fill),
              color: kOffWhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r)),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  ReusableText(
                      text: "Verify your phone number",
                      style: appStyle(18, kPrimary, FontWeight.w600)),
                  SizedBox(
                    height: 300.h, //250
                    child: Column(
                        children: List.generate(
                      verificationReasons.length,
                      (index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.check_circle_outline,
                            color: kPrimary,
                          ),
                          title: Text(
                            verificationReasons[index],
                            textAlign: TextAlign.justify,
                            style: appStyle(11, kGrayLight, FontWeight.normal),
                          ),
                        );
                      },
                    )),
                  ),
                  SizedBox(
                    height: 5.h, //10
                  ),
                  CustomButton(
                    text: "Verify Phone Number",
                    btnHeight: 30.h, //30
                    onTap: () {
                      // Get.to(() => const PhoneVerificationPage());
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
