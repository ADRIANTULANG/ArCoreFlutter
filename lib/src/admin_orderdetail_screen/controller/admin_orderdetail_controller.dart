import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:arproject/model/adminorders_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminOrderDetailController extends GetxController {
  AdminOrder orderDetail = AdminOrder(
    referenceNo: "",
      color: "",
      productID: '',
      proofPaymentUrlList: [],
      customerDetails: CustomerDetails(
          documentID: "",
          firstname: "",
          address: "",
          isVerified: false,
          provider: "",
          imageUrl: "",
          isOnline: false,
          fcmToken: "",
          userid: "",
          email: "",
          contactno: "",
          lastname: ""),
      dateTime: DateTime.now(),
      userAddress: "",
      quantity: 0,
      totalPrice: 0.0,
      woodType: "",
      price: 0.0,
      userContactno: "",
      productname: "",
      userEmail: "",
      productimage: "",
      status: "",
      id: "");
  RxBool isLoading = true.obs;
  RxString orderStatus = ''.obs;

  @override
  void onInit() async {
    orderDetail = await Get.arguments['orderDetail'];
    isLoading(false);
    orderStatus.value = orderDetail.status;

    super.onInit();
  }

  updateOrder(
      {required String ordeID,
      required String status,
      required String token}) async {
    try {
      String statusToUpdate = '';
      if (status == "Accepted") {
        statusToUpdate = "On Delivery";
      }
      if (status == "On Delivery") {
        statusToUpdate = "Completed";
      }

      if (status == "Completed") {
        Get.snackbar("Message", "Order Completed",
            backgroundColor: Colors.lightBlue, colorText: Colors.white);
      } else {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(ordeID)
            .update({
          "status": statusToUpdate,
        });
        sendNotif(
            message: "Order Code: $ordeID \n Status: $statusToUpdate",
            token: token);
        Get.snackbar("Message", "Order Status: $statusToUpdate",
            backgroundColor: Colors.lightBlue, colorText: Colors.white);
        orderDetail.status = statusToUpdate;
        orderStatus.value = statusToUpdate;
      }
    } catch (_) {}
  }

  sendNotif({required String message, required String token}) async {
    var body = jsonEncode({
      "to": token,
      "notification": {
        "body": message,
        "title": "MODSPACE",
        "subtitle": "",
      }
    });

    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          "Authorization":
              "key=AAAA69nG88w:APA91bFPyxCNWCxhrpXijaouHhLAR2f6NJkKIZsQzZT2qXIAanXAxZqLWqpOssX79lhNz5EYQrgJyV82ECpcc3gOLCu173KyRMZmkQGCN-unHtXtv3ly2FEsuJis8jjBE5FDUjY0UcGB",
          "Content-Type": "application/json"
        },
        body: body);
  }
}
