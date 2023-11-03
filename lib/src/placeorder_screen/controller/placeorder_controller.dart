import 'package:arproject/src/order_screen/controller/order_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/products_model.dart';
import '../../bottomnavigation_screen/controller/bottomnavigation_controller.dart';

class PlaceOrderController extends GetxController {
  final firebase = FirebaseFirestore.instance;
  Products product = Products(
      image: "",
      price: 0.0,
      name: "",
      description: "",
      isNew: false,
      specifications: [],
      woodTypes: [],
      quantity: 0.obs,
      id: "",
      arFile: "");
  RxBool isLoading = true.obs;
  RxString groupValue = ''.obs;

  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contactno = TextEditingController();

  DocumentReference<Map<String, dynamic>>? userDocumentID;

  @override
  void onInit() async {
    getUserDetails();
    product = await Get.arguments['product'];
    product.quantity.value = 1;
    isLoading(false);
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
      address.text = res.docs[0]['address'];
      email.text = res.docs[0]['email'];
      contactno.text = res.docs[0]['contactno'];
    }
  }

  placeOrder() async {
    isLoading(true);
    try {
      double totalPrice = product.quantity.value * product.price;
      await firebase.collection('orders').add({
        "woodType": groupValue.value,
        "orderedBy": userDocumentID!,
        "productname": product.name,
        "quantity": product.quantity.value,
        "price": product.price,
        "totalPrice": totalPrice,
        "productimage": product.image,
        "userEmail": email.text,
        "userAddress": address.text,
        "userContactno": contactno.text,
        "status": "Pending",
        "dateTime": Timestamp.now()
      });
      Get.back();
      Get.back();
      Get.snackbar("Message", "Successfully placed order",
          backgroundColor: Colors.lightBlue, colorText: Colors.white);
      Get.find<BottomNavigationController>().currentSelectedIndex.value = 1;
      Get.find<OrderController>().getOrders();
    } catch (e) {
      Get.snackbar("Message", "Something went wrong please try again later. $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    isLoading(false);
  }
}
