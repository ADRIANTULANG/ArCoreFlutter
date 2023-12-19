import 'package:arproject/config/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/faqs_controller.dart';

class FAQsView extends GetView<FAQsController> {
  const FAQsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FAQsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
      ),
      body: SizedBox(
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                    width: 100.w,
                    child: Center(
                      child: Text(
                        "Frequently Asked Questions",
                        style: Styles.header1,
                      ),
                    )),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  controller.text1,
                  style: Styles.mediumTextNormal,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  controller.text2,
                  style: Styles.mediumTextNormal,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  controller.text3,
                  style: Styles.mediumTextNormal,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  controller.text4,
                  style: Styles.mediumTextNormal,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  controller.text5,
                  style: Styles.mediumTextNormal,
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
