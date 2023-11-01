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
}
