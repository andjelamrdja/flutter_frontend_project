import 'dart:convert';

OrderRequest orderRequestFromJson(String str) =>
    OrderRequest.fromJson(json.decode(str));

String orderRequestToJson(OrderRequest data) => json.encode(data.toJson());

class OrderRequest {
  String userId;
  List<OrderItem> orderItems;
  double orderTotal;
  final double deliveryFee;
  double grandTotal;
  String deliveryAddress;
  String restaurantAddress;
  // String paymentMethod;
  // String paymentStatus;
  // String orderStatus;
  String restaurantId;
  List<double> restaurantCoords;
  List<double> recipientCoords;
  // String driverId;
  // int rating;
  // String feedback;
  // String promoCode;
  // int discountAmount;
  // String notes;

  OrderRequest({
    required this.userId,
    required this.orderItems,
    required this.orderTotal,
    required this.deliveryFee,
    required this.grandTotal,
    required this.deliveryAddress,
    required this.restaurantAddress,
    // required this.paymentMethod,
    // required this.paymentStatus,
    // required this.orderStatus,
    required this.restaurantId,
    required this.restaurantCoords,
    required this.recipientCoords,
    // required this.driverId,
    // required this.rating,
    // required this.feedback,
    // required this.promoCode,
    // required this.discountAmount,
    // required this.notes,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
        userId: json["userId"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        orderTotal: json["orderTotal"]?.toDouble(),
        deliveryFee: json["deliveryFee"]?.toDouble(),
        grandTotal: json["grandTotal"]?.toDouble(),
        deliveryAddress: json["deliveryAddress"],
        restaurantAddress: json["restaurantAddress"],
        // paymentMethod: json["paymentMethod"],
        // paymentStatus: json["paymentStatus"],
        // orderStatus: json["orderStatus"],
        restaurantId: json["restaurantId"],
        restaurantCoords: List<double>.from(
            json["restaurantCoords"].map((x) => x?.toDouble())),
        recipientCoords: List<double>.from(
            json["recipientCoords"].map((x) => x?.toDouble())),
        // driverId: json["driverId"],
        // rating: json["rating"],
        // feedback: json["feedback"],
        // promoCode: json["promoCode"],
        // discountAmount: json["discountAmount"],
        // notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderTotal": orderTotal,
        "deliveryFee": deliveryFee,
        "grandTotal": grandTotal,
        "deliveryAddress": deliveryAddress,
        "restaurantAddress": restaurantAddress,
        // "paymentMethod": paymentMethod,
        // "paymentStatus": paymentStatus,
        // "orderStatus": orderStatus,
        "restaurantId": restaurantId,
        "restaurantCoords": List<dynamic>.from(restaurantCoords.map((x) => x)),
        "recipientCoords": List<dynamic>.from(recipientCoords.map((x) => x)),
        // "driverId": driverId,
        // "rating": rating,
        // "feedback": feedback,
        // "promoCode": promoCode,
        // "discountAmount": discountAmount,
        // "notes": notes,
      };
}

class OrderItem {
  String foodId;
  int quantity;
  double price;
  List<String> additives;
  String instructions;

  OrderItem({
    required this.foodId,
    required this.quantity,
    required this.price,
    required this.additives,
    required this.instructions,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        foodId: json["foodId"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        additives: List<String>.from(json["additives"].map((x) => x)),
        instructions: json["instructions"],
      );

  Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "quantity": quantity,
        "price": price,
        "additives": List<dynamic>.from(additives.map((x) => x)),
        "instructions": instructions,
      };
}
