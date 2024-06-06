import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
// import '../../../ar_view.dart';
import '../../../services/getstorage_services.dart';
import '../../bottomnavigation_screen/view/bottomnavigation_view.dart';
import '../../terms_and_conditions_screen/view/terms_and_conditions_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigatTo();
    super.onInit();
  }

  navigatTo() async {
    Timer(const Duration(seconds: 4), () async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null && user.emailVerified) {
        Get.offAll(() => const BottomNavView());

        // Get.to(() => const MyWidget());
      } else {
        if (Get.find<StorageServices>().storage.read('isAgree') == null ||
            Get.find<StorageServices>().storage.read('isAgree') == false) {
          Get.offAll(() => const TermsAndConditionsView());
        } else {
          // Get.offAll(() => const LoginView());
          Get.offAll(() => const BottomNavView());
        }
      }
    });
  }
}
