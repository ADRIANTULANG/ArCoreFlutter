import 'dart:convert';
import 'package:arproject/model/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  RxList<Products> productsList = <Products>[].obs;
  RxList<Products> productsListMasterList = <Products>[].obs;

  TextEditingController search = TextEditingController();
  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  getProducts() async {
    try {
      var res = await FirebaseFirestore.instance.collection('products').get();
      var products = res.docs;
      List data = [];
      for (var i = 0; i < products.length; i++) {
        Map mapData = products[i].data();
        mapData['id'] = products[i].id;
        data.add(mapData);
      }
      productsList.assignAll(productsFromJson(jsonEncode(data)));
      productsListMasterList.assignAll(productsFromJson(jsonEncode(data)));
    } catch (_) {}
  }

  searchProduct({required String word}) async {
    productsList.clear();
    for (var i = 0; i < productsListMasterList.length; i++) {
      if (productsListMasterList[i]
              .name
              .toLowerCase()
              .toString()
              .contains(word.toLowerCase().toString()) ||
          productsListMasterList[i]
              .price
              .toString()
              .toLowerCase()
              .toString()
              .contains(word.toLowerCase().toString())) {
        productsList.add(productsListMasterList[i]);
      }
    }
  }

  deleteProduct({required String productID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productID)
          .delete();
      Get.back();
      Get.snackbar("Message", "Product deleted successfully",
          backgroundColor: Colors.lightBlue[50], colorText: Colors.black);
      getProducts();
    } catch (_) {}
  }
}
