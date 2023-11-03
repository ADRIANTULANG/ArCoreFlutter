import 'dart:convert';

import 'package:arproject/model/products_model.dart';
import 'package:get/get.dart';

import '../../../services/getstorage_services.dart';

class CartController extends GetxController {
  RxList<Products> cartList = <Products>[].obs;
  @override
  void onInit() {
    getItems();
    super.onInit();
  }

  getItems() async {
    List data = [];
    if (Get.find<StorageServices>().storage.read('cart') == null) {
      data = [];
    } else {
      data = Get.find<StorageServices>().storage.read('cart');
      cartList.assignAll(productsFromJson(jsonEncode(data)));
    }
  }
}
