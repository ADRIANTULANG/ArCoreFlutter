import 'dart:developer';

import 'package:arproject/services/authentication_services.dart';
import 'package:arproject/src/home_screen/view/home_view.dart';
import 'package:arproject/src/order_screen/view/order_view.dart';
import 'package:arproject/src/profile_screen/view/profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt currentSelectedIndex = 0.obs;

  List screens = [
    const HomeView(),
    const OrderView(),
    const ProfileView(),
  ];

  updateFcmToken() async {
    try {
      if (Get.find<AuthenticationService>().hasVerifiedUser.value) {
        String userID = FirebaseAuth.instance.currentUser!.uid;
        var res = await FirebaseFirestore.instance
            .collection('users')
            .where('userid', isEqualTo: userID)
            .get();
        if (res.docs.isNotEmpty) {
          String? token = await FirebaseMessaging.instance.getToken();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(res.docs[0].id)
              .update({"fcmToken": token});
        }
      }
    } on Exception catch (e) {
      log("ERROR (updateFcmToken): ${e.toString()}");
    }
  }

  @override
  void onInit() {
    updateFcmToken();
    super.onInit();
  }
}
