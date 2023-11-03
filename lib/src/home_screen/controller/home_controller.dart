import 'dart:convert';
import 'package:arproject/model/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../services/getstorage_services.dart';

class HomeController extends GetxController {
  final firebase = FirebaseFirestore.instance;
  RxList<Products> productListNew = <Products>[].obs;
  RxList<Products> productListAll = <Products>[].obs;
  RxInt cartCount = 0.obs;

  @override
  void onInit() {
    getProducts();
    getCartItems();
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
}
