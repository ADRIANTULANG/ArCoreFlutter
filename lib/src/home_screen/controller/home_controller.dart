import 'dart:async';
import 'dart:convert';
import 'package:arproject/model/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/getstorage_services.dart';

class HomeController extends GetxController {
  final firebase = FirebaseFirestore.instance;
  RxList<Products> productListNew = <Products>[].obs;
  RxList<Products> productListAll = <Products>[].obs;
  TextEditingController search = TextEditingController();
  RxInt cartCount = 0.obs;
  Timer? debounce;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    isLoading(true);
    await getProducts();
    await getCartItems();
    isLoading(false);

    super.onInit();
  }

  getProducts() async {
    var res = await firebase.collection('products').get();
    var products = res.docs;
    List dataNew = [];
    List dataAll = [];
    for (var i = 0; i < products.length; i++) {
      Map mapData = products[i].data();
      mapData['id'] = products[i].id;
      var resRate = await FirebaseFirestore.instance
          .collection('products')
          .doc(products[i].id)
          .collection('rate')
          .get();
      var rates = resRate.docs;
      List rateList = [];
      for (var x = 0; x < rates.length; x++) {
        Map mapRate = rates[x].data();
        mapRate['id'] = rates[x].id;
        rateList.add(mapRate);
      }

      mapData['rate'] = rateList;

      if (mapData['isNew'] == true) {
        dataNew.add(mapData);
      }
      dataAll.add(mapData);
    }
    productListNew.assignAll(productsFromJson(jsonEncode(dataNew)));
    productListAll.assignAll(productsFromJson(jsonEncode(dataAll)));
  }

  getCartItems() async {
    List data = [];
    if (Get.find<StorageServices>().storage.read('cart') == null) {
      data = [];
    } else {
      data = Get.find<StorageServices>().storage.read('cart');
      cartCount.value = data.length;
    }
  }

  RxString getRates({required List<Rate> ratings}) {
    double totalrate = 0.0;
    for (var i = 0; i < ratings.length; i++) {
      totalrate = totalrate + ratings[i].rate;
    }
    RxString rate = (totalrate / ratings.length).toString().obs;
    if (totalrate == 0) {
      rate = "0".obs;
    } else {
      rate = (totalrate / ratings.length).toString().obs;
    }
    return rate;
  }
}
