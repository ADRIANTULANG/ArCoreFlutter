import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/products_model.dart';

class SearchProductController extends GetxController {
  RxList<Products> productList = <Products>[].obs;
  RxList<Products> productListMasterList = <Products>[].obs;
  TextEditingController search = TextEditingController();

  Timer? debounce;

  @override
  void onInit() async {
    String productsearchkeyword = await await Get.arguments['word'];
    var products = await Get.arguments['products'];
    productList.assignAll(products);
    productListMasterList.assignAll(products);
    searchProduct(word: productsearchkeyword);
    search.text = productsearchkeyword;
    super.onInit();
  }

  searchProduct({required String word}) async {
    productList.clear();
    for (var i = 0; i < productListMasterList.length; i++) {
      if (productListMasterList[i]
          .name
          .toLowerCase()
          .toString()
          .contains(word.toLowerCase().toString())) {
        productList.add(productListMasterList[i]);
      }
    }
  }
}
