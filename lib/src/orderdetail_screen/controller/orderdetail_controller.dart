import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/orders_model.dart';
import '../../../model/products_model.dart';
import '../../placeorder_screen/view/placeorder_view.dart';

class OrderDetailController extends GetxController {
  OrderModel orderDetail = OrderModel(
      referenceNo: "",
      productID: '',
      proofPaymentUrlList: [],
      dateTime: DateTime.now(),
      userAddress: "",
      quantity: 0,
      totalPrice: 0.0,
      woodType: "",
      price: 0.0,
      userContactno: "",
      productname: "",
      shippingfee: 0.0,
      userEmail: "",
      productimage: "",
      status: "",
      id: "");
  RxBool isLoading = true.obs;
  RxList<Products> productList = <Products>[].obs;
  RxBool showRatingButton = false.obs;

  @override
  void onInit() async {
    orderDetail = await Get.arguments['orderDetail'];
    showRatingButton.value = orderDetail.status == "Completed" ? true : false;
    isLoading(false);
    super.onInit();
  }

  reOrder({required String productID}) async {
    isLoading(true);
    var res = await FirebaseFirestore.instance
        .collection('products')
        .doc(productID)
        .get();

    if (res.exists) {
      Map<String, dynamic> product = res.data()!;
      product['id'] = res.id;
      var resRate = await FirebaseFirestore.instance
          .collection('products')
          .doc(res.id)
          .collection('rate')
          .get();
      var rates = resRate.docs;
      List rateList = [];
      for (var x = 0; x < rates.length; x++) {
        Map mapRate = rates[x].data();
        mapRate['id'] = rates[x].id;
        rateList.add(mapRate);
      }
      product['rate'] = rateList;
      List data = [];
      data.add(product);
      productList.assignAll(productsFromJson(jsonEncode(data)));
      if (productList.isNotEmpty) {
        Get.to(() => const PlaceOrderView(),
            arguments: {'product': productList[0]});
      }
    }
    Future.delayed(const Duration(seconds: 2), () {
      isLoading(false);
    });
  }

  addRating({required double rate, required String comment}) async {
    var isUserExist = await FirebaseFirestore.instance
        .collection('products')
        .doc(orderDetail.productID)
        .collection('rate')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    var res = await FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    String email = 'Unknown User';
    if (res.docs.isNotEmpty) {
      email = res.docs[0].get('email');
    }
    log(orderDetail.productID);
    if (isUserExist.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(orderDetail.productID)
          .collection('rate')
          .add({
        "rate": rate,
        "userid": FirebaseAuth.instance.currentUser!.uid,
        "comment": comment,
        'email': email
      });
    } else {
      var ratedocID = await FirebaseFirestore.instance
          .collection('products')
          .doc(orderDetail.productID)
          .collection('rate')
          .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      await FirebaseFirestore.instance
          .collection('products')
          .doc(orderDetail.productID)
          .collection('rate')
          .doc(ratedocID.docs[0].id)
          .update({
        "rate": rate,
        "comment": comment,
      });
    }
    Get.back();
    Get.snackbar("Message", "Thank you for your feedback!",
        backgroundColor: Colors.lightBlue, colorText: Colors.white);
  }
}
