import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../model/orders_model.dart';

class OrderController extends GetxController {
  final firebase = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>>? userDocumentID;

  RxList<OrderModel> orderList = <OrderModel>[].obs;

  @override
  void onInit() async {
    await getUserDetails();
    getOrders();
    super.onInit();
  }

  getUserDetails() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var res = await firebase
        .collection('users')
        .where('userid', isEqualTo: user!.uid)
        .limit(1)
        .get();

    if (res.docs.isNotEmpty) {
      userDocumentID = firebase.collection('users').doc(res.docs[0].id);
    }
  }

  getOrders() async {
    var res = await firebase
        .collection('orders')
        .where('orderedBy', isEqualTo: userDocumentID!)
        .where('status', isEqualTo: "Pending")
        .orderBy('dateTime', descending: true)
        .get();
    var orders = res.docs;
    List data = [];
    for (var i = 0; i < orders.length; i++) {
      Map mapData = orders[i].data();
      mapData['id'] = orders[i].id;
      mapData['dateTime'] = mapData['dateTime'].toDate().toString();
      mapData.remove('orderedBy');
      data.add(mapData);
    }
    orderList.assignAll(orderModelFromJson(jsonEncode(data)));
  }
}
