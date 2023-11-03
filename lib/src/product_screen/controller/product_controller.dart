import 'package:arproject/services/getstorage_services.dart';
import 'package:arproject/src/home_screen/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/products_model.dart';

class ProductController extends GetxController {
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
  @override
  void onInit() async {
    product = await Get.arguments['product'];
    isLoading(false);
    super.onInit();
  }

  saveToCart() async {
    List cartList = [];
    if (Get.find<StorageServices>().storage.read('cart') == null) {
      cartList = [];
      Map mapData = {
        "image": product.image,
        "price": product.price,
        "name": product.name,
        "description": product.description,
        "specifications": product.specifications,
        "woodTypes": product.woodTypes,
        "quantity": product.quantity.value,
        "id": product.id,
        "arFile": product.arFile,
      };
      cartList.add(mapData);
    } else {
      cartList = Get.find<StorageServices>().storage.read('cart');
      bool itemExist = false;
      for (var i = 0; i < cartList.length; i++) {
        if (cartList[i]['id'] == product.id) {
          itemExist = true;
        }
      }
      if (itemExist == false) {
        cartList.add({
          "image": product.image,
          "price": product.price,
          "name": product.name,
          "description": product.description,
          "specifications": product.specifications,
          "woodTypes": product.woodTypes,
          "quantity": product.quantity.value,
          "id": product.id,
          "arFile": product.arFile,
        });
      }
    }
    await Get.find<StorageServices>().saveToCart(cartList: cartList);
    for (var i = 0;
        i < Get.find<StorageServices>().storage.read('cart').length;
        i++) {}
    Get.snackbar("Message", "Product added to cart",
        backgroundColor: Colors.lightBlue, colorText: Colors.white);
    Get.find<HomeController>().getCartItems();
  }
}
