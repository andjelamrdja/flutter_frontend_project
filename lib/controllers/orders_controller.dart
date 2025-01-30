import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project_andjela/constants/constants.dart';
import 'package:flutter_project_andjela/models/api_error.dart';
import 'package:flutter_project_andjela/models/order_request.dart';
import 'package:flutter_project_andjela/models/order_response.dart';
import 'package:flutter_project_andjela/models/payment_request.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrdersController extends GetxController {
  final box = GetStorage();
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  RxString _paymentUrl = ''.obs;
  String get paymentUrl => _paymentUrl.value;

  set setPaymentUrl(String newState) {
    _paymentUrl.value = newState;
  }

  String orderId = '';
  String get getOrderId => orderId;
  set setOrderId(String newState) {
    orderId = newState;
  }

  OrderRequest? order;

  RxBool _iconChanger = false.obs;

  bool get iconChanger => _iconChanger.value;

  set setIcon(bool newValue) {
    _iconChanger.value = newValue;
  }

  void createOrder(String data, OrderRequest item) async {
    final box = GetStorage();
    String accessToken = box.read("token");

    Uri url = Uri.parse('$appBaseUrl/api/orders');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 201) {
        OrderResponse data = orderResponseFromJson(response.body);
        setOrderId = data.orderId;

        // Cart item
        Payment payment = Payment(userId: item.userId, cartItems: [
          CartItem(
              name: item.orderItems[0].foodId,
              id: data.orderId,
              price: item.grandTotal.toStringAsFixed(2),
              quantity: 1,
              restaurantId: item.restaurantId)
        ]);

        // Payment function
        String paymentData = paymentToJson(payment);

        paymentFunction(paymentData);
      } else {
        var error = apiErrorFromJson(response.body);

        Get.snackbar("Failed to add address", error.message,
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error_outline));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void paymentFunction(String payment) async {
    setLoading = true;
    var url = Uri.parse(
        'https://flutterpaymentproject-production.up.railway.app/stripe/create-checkout-session');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: payment,
      );

      if (response.statusCode == 200) {
        var urlData = jsonDecode(response.body);

        setPaymentUrl = urlData['url'];

        setLoading = false;
      }
    } catch (error) {
      setLoading = false;
      debugPrint(error.toString());
    } finally {
      setLoading = false;
    }
  }
  // https://flutterpaymentproject-production.up.railway.app/stripe/create-checkout-session
}
