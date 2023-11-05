import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../login_screen/view/login_view.dart';
import '../controller/admin_home_controller.dart';

class AdminHomeScreenAlertDialog {
  static showDeleteProduct(
      {required AdminHomeController controller,
      required String productID}) async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 20.h,
      width: 100.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Delete Product?",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "No",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  )),
              TextButton(
                  onPressed: () async {
                    controller.deleteProduct(productID: productID);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp),
                  ))
            ],
          )
        ],
      ),
    )));
  }

  static showLogoutConfirmation() async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 20.h,
      width: 100.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Log out?",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "No",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  )),
              TextButton(
                  onPressed: () async {
                    Get.offAll(() => const LoginView());
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp),
                  ))
            ],
          )
        ],
      ),
    )));
  }
}
