import 'package:arproject/src/admin_report_screen/controller/admin_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AdminReportScreenAlertDialog {
  static showEditShippingFee(
      {required AdminReportController controller,
      required String oldFee}) async {
    TextEditingController fee = TextEditingController();
    fee.text = oldFee;
    Get.dialog(AlertDialog(
        actions: [
          Obx(
            () => controller.isLoadingEdit.value
                ? const SizedBox()
                : TextButton(
                    onPressed: () {
                      controller.editShippingFee(fee: fee.text);
                    },
                    child: const Text("Set")),
          )
        ],
        content: Obx(
          () => Container(
            height: controller.isLoadingEdit.value ? 16.h : 10.h,
            width: 100.w,
            color: Colors.white,
            child: Obx(
              () => controller.isLoadingEdit.value
                  ? Center(
                      child: SizedBox(
                        child: Center(
                          child: SpinKitThreeBounce(
                            color: Colors.lightBlue,
                            size: 30.sp,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Please put an amount?",
                          style: TextStyle(
                              fontFamily: 'Bariol',
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        SizedBox(
                          height: 6.h,
                          width: 100.w,
                          child: TextField(
                            controller: fee,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*$')),
                            ],
                            decoration: InputDecoration(
                                fillColor: Colors.lightBlue[50],
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 3.w, top: 2.h),
                                alignLabelWithHint: false,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                hintStyle:
                                    const TextStyle(fontFamily: 'Bariol')),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        )));
  }
}
