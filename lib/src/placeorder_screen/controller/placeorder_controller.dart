import 'dart:io';
import 'dart:typed_data';

import 'package:arproject/src/cart_screen/controller/cart_controller.dart';
import 'package:arproject/src/home_screen/controller/home_controller.dart';
import 'package:arproject/src/order_screen/controller/order_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/products_model.dart';
import '../../../services/getstorage_services.dart';
import '../../bottomnavigation_screen/controller/bottomnavigation_controller.dart';
import '../../orderdetail_screen/controller/orderdetail_controller.dart';
import '../../search_screen/controller/search_controller.dart';

class PlaceOrderController extends GetxController {
  final firebase = FirebaseFirestore.instance;
  Products product = Products(
      stocks: "0",
      colors: [],
      rate: <Rate>[],
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
  RxString groupWoodTypeValue = ''.obs;
  RxString groupColorTypeValue = ''.obs;

  TextEditingController address = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController baramgay = TextEditingController();
  TextEditingController municipality = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController contactno = TextEditingController();
  TextEditingController referenceNo = TextEditingController();

  DocumentReference<Map<String, dynamic>>? userDocumentID;

  RxList proofImageList = [].obs;

  ImagePicker picker = ImagePicker();

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
      List proofPaymentUrlList = [];
      for (var i = 0; i < proofImageList.length; i++) {
        var modeluint8list =
            Uint8List.fromList(File(proofImageList[i]).readAsBytesSync());
        String fileName = proofImageList[i].split('/').last;
        final ref =
            FirebaseStorage.instance.ref().child("proofpayments/$fileName");
        var uploadTask = ref.putData(modeluint8list);
        final snapshot = await uploadTask.whenComplete(() {});
        var modelLink = await snapshot.ref.getDownloadURL();
        proofPaymentUrlList.add(modelLink);
      }

      double totalPrice = product.quantity.value * product.price;
      await firebase.collection('orders').add({
        "productID": product.id,
        "woodType": groupWoodTypeValue.value,
        "orderedBy": userDocumentID!,
        "productname": product.name,
        "color": groupColorTypeValue.value,
        "quantity": product.quantity.value,
        "price": product.price,
        "totalPrice": totalPrice,
        "productimage": product.image,
        "userEmail": email.text,
        "userAddress": address.text,
        "userContactno": contactno.text,
        "status": "Pending",
        "dateTime": Timestamp.now(),
        "proofPaymentUrlList": proofPaymentUrlList,
        "referenceNo": referenceNo.text
      });
      if (Get.isRegistered<CartController>() == true) {
        await removeItemFromCart();
        Get.back();
        Get.back();
        Get.back();
      } else if (Get.isRegistered<SearchProductController>() == true) {
        Get.back();
        Get.back();
        Get.back();
      } else if (Get.isRegistered<OrderDetailController>() == true) {
        Get.back();
        Get.back();
      } else {
        Get.back();
        Get.back();
      }
      Get.snackbar("Message", "Successfully placed order",
          backgroundColor: Colors.lightBlue, colorText: Colors.white);
      Get.find<BottomNavigationController>().currentSelectedIndex.value = 1;
      Get.find<OrderController>().getOrders();
      Get.find<HomeController>().getCartItems();
    } catch (e) {
      Get.snackbar("Message", "Something went wrong please try again later. $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    isLoading(false);
  }

  removeItemFromCart() async {
    if (Get.find<StorageServices>().storage.read('cart') != null) {
      List cartList = Get.find<StorageServices>().storage.read('cart');
      cartList.removeWhere((element) => element['id'] == product.id);
      Get.find<StorageServices>().saveToCart(cartList: cartList);
    }
  }

  pickImageFromGallery() async {
    List<XFile> images = await picker.pickMultiImage();
    for (var i = 0; i < images.length; i++) {
      proofImageList.add(images[i].path);
    }
  }
}
