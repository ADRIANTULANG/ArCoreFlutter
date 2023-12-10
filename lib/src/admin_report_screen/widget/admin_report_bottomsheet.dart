import 'package:arproject/src/admin_report_screen/controller/admin_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AdminReportBottomSheet {
  static showDatePicker({required AdminReportController controller}) async {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
        height: 40.h,
        width: 100.w,
        child: SfDateRangePicker(
          onSelectionChanged: controller.onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 3))),
        ),
      ),
    );
  }
}
