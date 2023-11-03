import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices extends GetxController {
  final storage = GetStorage();

  saveToCart({required List cartList}) async {
    storage.write("cart", cartList);
  }
}
