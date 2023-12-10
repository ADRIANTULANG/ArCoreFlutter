import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/adminorders_model.dart';
import 'package:http/http.dart' as http;

class AdminOrderController extends GetxController {
  Stream? streamChats;
  StreamSubscription<dynamic>? listener;
  RxList<AdminOrder> ordersList = <AdminOrder>[].obs;
  RxList<AdminOrder> ordersListMasterList = <AdminOrder>[].obs;

  TextEditingController search = TextEditingController();

  @override
  void onInit() {
    listenToChanges();
    super.onInit();
  }

  listenToChanges() async {
    streamChats = FirebaseFirestore.instance
        .collection("orders")
        .orderBy('dateTime', descending: false)
        .snapshots();
    getOrders();
  }

  getOrders() async {
    try {
      listener = streamChats!.listen((event) async {
        List data = [];
        for (var orders in event.docs) {
          Map mapData = orders.data();
          mapData['id'] = orders.id;
          mapData['dateTime'] = mapData['dateTime'].toDate().toString();
          var customerDetailsDocumentReference =
              mapData['orderedBy'] as DocumentReference;
          var customer = await customerDetailsDocumentReference.get();
          mapData.remove('orderedBy');
          mapData['customerDetails'] = customer.data();
          mapData['customerDetails']['documentID'] = customer.id;
          data.add(mapData);
        }
        var encodedData = jsonEncode(data);
        ordersList.assignAll(adminOrderFromJson(encodedData));
        ordersListMasterList.assignAll(adminOrderFromJson(encodedData));
      });
    } catch (_) {}
  }

  updateOrder(
      {required String ordeID,
      required String status,
      required String fcmToken}) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(ordeID).update({
        "status": status,
      });
      sendNotif(
          message: "Order Code: $ordeID \n Status: $status", token: fcmToken);
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

  searchProduct({required String word}) async {
    ordersList.clear();
    for (var i = 0; i < ordersListMasterList.length; i++) {
      if (ordersListMasterList[i]
              .id
              .toLowerCase()
              .toString()
              .contains(word.toLowerCase().toString()) ||
          ordersListMasterList[i]
              .productname
              .toString()
              .toLowerCase()
              .toString()
              .contains(word.toLowerCase().toString())) {
        ordersList.add(ordersListMasterList[i]);
      }
    }
  }
}
