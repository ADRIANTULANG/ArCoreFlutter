// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  DateTime dateTime;
  String userAddress;
  int quantity;
  double totalPrice;
  String woodType;
  double price;
  String userContactno;
  String productname;
  String userEmail;
  String productimage;
  String status;
  String id;
  String productID;
  List<String> proofPaymentUrlList;

  OrderModel({
    required this.dateTime,
    required this.userAddress,
    required this.quantity,
    required this.totalPrice,
    required this.woodType,
    required this.price,
    required this.userContactno,
    required this.productname,
    required this.userEmail,
    required this.productimage,
    required this.status,
    required this.id,
    required this.proofPaymentUrlList,
    required this.productID,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        dateTime: DateTime.parse(json["dateTime"]),
        userAddress: json["userAddress"],
        quantity: json["quantity"],
        totalPrice: double.parse(json["totalPrice"].toString()),
        proofPaymentUrlList:
            List<String>.from(json["proofPaymentUrlList"].map((x) => x)),
        woodType: json["woodType"],
        price: double.parse(json["price"].toString()),
        userContactno: json["userContactno"],
        productname: json["productname"],
        userEmail: json["userEmail"],
        productimage: json["productimage"],
        status: json["status"],
        id: json["id"],
        productID: json["productID"],
      );

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime.toIso8601String(),
        "userAddress": userAddress,
        "quantity": quantity,
        "proofPaymentUrlList": proofPaymentUrlList,
        "totalPrice": totalPrice,
        "woodType": woodType,
        "price": price,
        "userContactno": userContactno,
        "productname": productname,
        "userEmail": userEmail,
        "productimage": productimage,
        "status": status,
        "id": id,
        "productID": productID,
      };
}
