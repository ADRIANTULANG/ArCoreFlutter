import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/textstyles.dart';
import '../controller/login_controller.dart';

class LoginAlertdialog {
  static showLoadingDialog() async {
    Get.dialog(
        AlertDialog(
          content: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  height: 8.h,
                  width: 60.w,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Center(
                        child: SpinKitThreeBounce(
                          size: 25.sp,
                          color: Colors.lightBlue,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const Text("Loading...")
                    ],
                  )),
            ),
          ),
        ),
        barrierDismissible: false);
  }

  static showDialogForgotPassword({required LoginController controller}) async {
    TextEditingController email = TextEditingController();
    Get.dialog(
      AlertDialog(
        content: Container(
          height: 20.h,
          width: 100.w,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                width: 100.w,
                child: Text(
                  "Enter Email",
                  style: Styles.header1,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 7.h,
                width: 100.w,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      fillColor: Colors.lightBlue[50],
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w),
                      alignLabelWithHint: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: 'Email'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Back", style: Styles.mediumTextBold)),
                  TextButton(
                      onPressed: () {
                        if (email.text.isEmail == true) {
                          controller.forgotPassword(email: email.text);
                        } else {
                          Get.snackbar("Message", "Invalid Email");
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
