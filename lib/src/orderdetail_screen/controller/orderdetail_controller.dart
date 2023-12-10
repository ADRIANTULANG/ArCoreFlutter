import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../model/orders_model.dart';
import '../../../model/products_model.dart';
import '../../placeorder_screen/view/placeorder_view.dart';

class OrderDetailController extends GetxController {
  OrderModel orderDetail = OrderModel(
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
      userEmail: "",
      productimage: "",
      status: "",
      id: "");
  RxBool isLoading = true.obs;
  RxList<Products> productList = <Products>[].obs;

  @override
  void onInit() async {
    orderDetail = await Get.arguments['orderDetail'];
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
}
