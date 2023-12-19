import 'package:get/get.dart';

import '../../../services/getstorage_services.dart';

class TermsAndConditionsController extends GetxController {
  String text1 =
      "Welcome to our FOUR-J. Our online store, Modspace, and its associates provided their service subject to the following conditions: By downloading or using Modspade ('Mobile Application Online Furniture Shop with Augmented Reality'), you agree to be bound by the terms and conditions. Please read carefully.";
  String text2 =
      "You are corresponding with us online when you launch the application modspace. By using the app's chat feature, giving us your phone number, or sending you a message on Facebook, you agree to receive communications from us online. You accept all terms, conditions, disclosures, and other Any legal need that communications be made in writing is satisfied by correspondence that we send to you online.";
  RxBool isAgree = false.obs;
  @override
  void onInit() {
    if (Get.find<StorageServices>().storage.read('isAgree') != null) {
      isAgree.value = Get.find<StorageServices>().storage.read('isAgree');
    }
    super.onInit();
  }
}
