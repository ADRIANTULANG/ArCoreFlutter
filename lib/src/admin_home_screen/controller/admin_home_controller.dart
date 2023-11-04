import 'dart:convert';

import 'package:arproject/model/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  RxList<Products> productsList = <Products>[].obs;
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
    } catch (_) {}
  }
}
