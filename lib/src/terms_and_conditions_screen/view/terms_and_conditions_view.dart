import 'package:arproject/services/getstorage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/textstyles.dart';
import '../../bottomnavigation_screen/view/bottomnavigation_view.dart';
import '../controller/terms_and_condition_controller.dart';

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TermsAndConditionsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading:
            Get.find<StorageServices>().storage.read('isAgree') == null ||
                    Get.find<StorageServices>().storage.read('isAgree') == false
                ? false
                : true,
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
                        "Terms and Conditions",
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          Get.find<StorageServices>().storage.read('isAgree') == null ||
                  Get.find<StorageServices>().storage.read('isAgree') == false
              ? SizedBox(
                  height: 16.h,
                  width: 100.w,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                                activeColor: Colors.lightBlue,
                                value: controller.isAgree.value,
                                onChanged: (value) {
                                  controller.isAgree.value = value!;
                                }),
                          ),
                          Text(
                            "By checking this box, you are agreeing to our terms of service.",
                            style: Styles.smalltextGrey,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: SizedBox(
                          width: 100.w,
                          height: 7.h,
                          child: Obx(
                            () => ElevatedButton(
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(
                                      Colors.white),
                                  backgroundColor: controller.isAgree.value == false
                                      ? MaterialStateProperty.all<Color>(
                                          Colors.grey)
                                      : MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              255, 156, 213, 240)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          side: const BorderSide(color: Colors.white)))),
                              onPressed: () {
                                if (controller.isAgree.value == true) {
                                  Get.find<StorageServices>()
                                      .agreeToTermsAndConditions(isAgree: true);
                                  Get.offAll(() => const BottomNavView());
                                }
                              },
                              child: Text("PROCEED", style: Styles.header1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
    );
  }
}
