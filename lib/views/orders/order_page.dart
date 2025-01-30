import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/common/app_style.dart';
import 'package:flutter_project_andjela/common/background_container.dart';
import 'package:flutter_project_andjela/common/reusable_text.dart';
import 'package:flutter_project_andjela/common/shimmers/custom_button.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/controllers/orders_controller.dart';
import 'package:flutter_project_andjela/models/adresses_response.dart';
import 'package:flutter_project_andjela/models/distance_time.dart';
import 'package:flutter_project_andjela/models/foods.dart';
import 'package:flutter_project_andjela/models/order_request.dart';
import 'package:flutter_project_andjela/models/restaurants.dart';
import 'package:flutter_project_andjela/services/distance.dart';
import 'package:flutter_project_andjela/views/orders/widgets/order_tile.dart';
import 'package:flutter_project_andjela/views/restaurant/widget/row_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderPage extends StatelessWidget {
  const OrderPage(
      {super.key,
      this.restaurant,
      required this.food,
      required this.item,
      this.address});
  final RestaurantsModel? restaurant;
  final FoodsModel food;
  final OrderItem item;
  final AddressResponse? address;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    DistanceTime data = Distance().calculateDistanceTimePrice(
        // ovo je neka moja varijanta za pristupanje koordinatama
        restaurant!.coords.latitude,
        restaurant!.coords.latitude,
        restaurant!.coords.longitude,
        restaurant!.coords.latitude,
        restaurant!.coords.longitude,
        10,
        2);

    double totalPrice = item.price + data.price;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
          backgroundColor: kPrimary,
          title: ReusableText(
              text: "Complete Ordering",
              style: appStyle(13, kLightWhite, FontWeight.w600))),
      body: BackGroundContainer(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              OrderTile(food: food),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                width: width,
                height: height / 3.5,
                decoration: BoxDecoration(
                    color: kOffWhite,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                            text: restaurant!.title,
                            style: appStyle(20, kGray, FontWeight.bold)),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: kPrimary,
                          backgroundImage: NetworkImage(restaurant!.logoUrl),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(
                      first: "Business Hours",
                      second: restaurant!.time,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(
                      first: "Distance from Restaurant",
                      second: "${data.distance.toStringAsFixed(2)} km",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RowText(
                      first: "Price from restaurant",
                      second: "\$ ${data.price.toStringAsFixed(2)}",
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowText(
                      first: "Order total",
                      second: "\$ ${item.price.toString()}",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RowText(
                      first: "Grand total",
                      second: "\$ ${totalPrice.toStringAsFixed(2)}",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ReusableText(
                        text: "Additives:",
                        style: appStyle(20, kGray, FontWeight.bold)),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: width,
                      height: 15.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: item
                              .additives.length, //ovdje bi trebalo bez widget
                          itemBuilder: (context, i) {
                            String additive = item.additives[i]; // i ovdje
                            return Container(
                              margin: EdgeInsets.only(right: 5.w),
                              decoration: BoxDecoration(
                                color: kSecondaryLight,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(9.r),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(2.h),
                                  child: ReusableText(
                                      text: additive,
                                      style:
                                          appStyle(8, kGray, FontWeight.w400)),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                text: "Proceed to payment",
                btnHeight: 45,
                onTap: () {
                  OrderRequest order = OrderRequest(
                      userId: address!.userId,
                      orderItems: [item],
                      orderTotal: item.price,
                      deliveryFee: data.price,
                      grandTotal: totalPrice,
                      deliveryAddress: address!.id,
                      restaurantAddress: restaurant!.coords.address,
                      restaurantId: restaurant!.id,
                      restaurantCoords: [
                        restaurant!.coords.latitude,
                        restaurant!.coords.longitude
                      ],
                      recipientCoords: [address!.latitude, address!.longitude]);

                  String orderData = orderRequestToJson(order);

                  controller.createOrder(orderData);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
