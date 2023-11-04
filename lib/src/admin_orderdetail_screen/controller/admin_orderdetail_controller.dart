import 'package:arproject/model/adminorders_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminOrderDetailController extends GetxController {
  AdminOrder orderDetail = AdminOrder(
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

  updateOrder({required String ordeID, required String status}) async {
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
        Get.snackbar("Message", "Order Status: $statusToUpdate",
            backgroundColor: Colors.lightBlue, colorText: Colors.white);
        orderDetail.status = statusToUpdate;
        orderStatus.value = statusToUpdate;
      }
    } catch (_) {}
  }
}
