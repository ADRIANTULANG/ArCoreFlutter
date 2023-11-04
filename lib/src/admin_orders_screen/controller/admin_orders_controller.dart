import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../model/adminorders_model.dart';

class AdminOrderController extends GetxController {
  Stream? streamChats;
  StreamSubscription<dynamic>? listener;
  RxList<AdminOrder> ordersList = <AdminOrder>[].obs;

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
      });
    } catch (_) {}
  }

  updateOrder({required String ordeID, required String status}) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(ordeID).update({
        "status": status,
      });
    } catch (_) {}
  }
}
