import 'package:arproject/config/textstyles.dart';
import 'package:arproject/src/login_screen/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NoVerifiedUserView extends StatelessWidget {
  const NoVerifiedUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.h,
            width: 100.w,
            child: Image.asset('assets/images/nouser.png'),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            "Welcome! to access this page, please log in first. Thank you!",
            textAlign: TextAlign.center,
            style: Styles.mediumTextBold,
          ),
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                  Colors.lightBlue[100],
                )),
                onPressed: () {
                  Get.to(() => const LoginView());
                },
                child: Text(
                  "Login",
                  style: Styles.mediumTextBoldWhite,
                )),
          )
        ],
      ),
    );
  }
}
