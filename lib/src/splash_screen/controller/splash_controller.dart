import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
// import '../../../ar_view.dart';
import '../../bottomnavigation_screen/view/bottomnavigation_view.dart';
import '../../login_screen/view/login_view.dart';

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
        Get.offAll(() => const LoginView());
      }
    });
  }
}
