import 'package:get/get.dart';

import '../../../model/orders_model.dart';

class OrderDetailController extends GetxController {
  OrderModel orderDetail = OrderModel(
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

  @override
  void onInit() async {
    orderDetail = await Get.arguments['orderDetail'];
    isLoading(false);
    super.onInit();
  }
}
