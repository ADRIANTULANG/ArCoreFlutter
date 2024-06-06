import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationService extends GetxService {
  RxString userid = ''.obs;
  RxBool isEmailVerified = false.obs;
  RxBool hasVerifiedUser = false.obs;

  checkAuthentication() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user?.uid != null) {
      userid.value = user!.uid;
    }
    if (user?.emailVerified != null) {
      isEmailVerified.value = user!.emailVerified;
    }
    if (userid.value != "" && isEmailVerified.value) {
      hasVerifiedUser.value = true;
    }
    log("USERID:::${userid.value}");
    log("VERIFIED:::${isEmailVerified.value.toString()}");
  }

  @override
  void onInit() {
    checkAuthentication();
    super.onInit();
  }
}
