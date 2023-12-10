import 'package:arproject/services/getstorage_services.dart';
import 'package:arproject/src/home_screen/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/products_model.dart';

class ProductController extends GetxController {
  Products product = Products(
      stocks: "0",
      colors: [],
      image: "",
      price: 0.0,
      name: "",
      description: "",
      isNew: false,
      specifications: [],
      woodTypes: [],
      quantity: 0.obs,
      rate: <Rate>[],
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

  addRating({required double rate, required String comment}) async {
    var isUserExist = await FirebaseFirestore.instance
        .collection('products')
        .doc(product.id)
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
    if (isUserExist.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.id)
          .collection('rate')
          .add({
        "rate": rate,
        "userid": FirebaseAuth.instance.currentUser!.uid,
        "comment": comment,
        'email': email
      });
    } else {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.id)
          .collection('rate')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "rate": rate,
        "comment": comment,
      });
    }
    Get.back();
    Get.snackbar("Message", "Thank you for your feedback!",
        backgroundColor: Colors.lightBlue, colorText: Colors.white);
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
