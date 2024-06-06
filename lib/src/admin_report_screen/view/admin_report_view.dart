import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../config/textstyles.dart';
import '../../../model/chart_data_model.dart';
import '../../../services/getstorage_services.dart';
import '../../googlemap_screen/view/google_map_admin_view.dart';
import '../controller/admin_report_controller.dart';
import '../widget/admin_report_alertdialog.dart';
import '../widget/admin_report_bottomsheet.dart';

class AdminReportView extends GetView<AdminReportController> {
  const AdminReportView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminReportController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
      ),
      body: Obx(
        () => controller.isLoading.value == true
            ? SizedBox(
                height: 100.h,
                width: 100.w,
                child: Center(
                  child: SpinKitThreeBounce(
                    color: Colors.lightBlue,
                    size: 35.sp,
                  ),
                ),
              )
            : Get.find<StorageServices>().storage.read('usertype') == "Seller"
                ? SizedBox(
                    child: Center(
                      child: Text(
                        "You don't have permission to view this page.",
                        style: Styles.mediumTextNormal,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: InkWell(
                            onTap: () {
                              AdminReportBottomSheet.showDatePicker(
                                  controller: controller);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                      child: Obx(() => Text(
                                            controller.selectedDateRange.value,
                                            style: Styles.mediumTextBold,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                const Icon(Icons.calendar_month_rounded),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 17.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.lightBlue,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              255, 202, 196, 196),
                                          blurRadius: 5,
                                          spreadRadius: 3,
                                          offset: Offset(1, 2))
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 3.w,
                                        right: 3.w,
                                        bottom: 2.h,
                                        top: 2.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 5.h,
                                            width: 7.w,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: const Icon(
                                                Icons.attach_money_rounded)),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Income",
                                              style: Styles.header2White,
                                            ),
                                            Obx(
                                              () => Text(
                                                controller.totalIncome.value
                                                    .toStringAsFixed(2),
                                                style: Styles.header2White,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Expanded(
                                child: Container(
                                  height: 17.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.lightBlue,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              255, 202, 196, 196),
                                          blurRadius: 5,
                                          spreadRadius: 3,
                                          offset: Offset(1, 2))
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 3.w,
                                        right: 3.w,
                                        bottom: 2.h,
                                        top: 2.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 5.h,
                                            width: 7.w,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: Icon(
                                              Icons.pending_actions,
                                              size: 16.sp,
                                            )),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Orders",
                                              style: Styles.header2White,
                                            ),
                                            Obx(
                                              () => Text(
                                                controller.ordersList.length
                                                    .toString(),
                                                style: Styles.header2White,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Shipping fee per KM: ",
                                    style: Styles.mediumTextBold,
                                  ),
                                  Obx(
                                    () => Text(
                                      " ₱${controller.perKMfee.value}",
                                      style: Styles.mediumTextBold,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.lightBlue)),
                                  onPressed: () {
                                    AdminReportScreenAlertDialog
                                        .showEditShippingFee(
                                            controller: controller,
                                            oldFee: controller.perKMfee.value
                                                .toString());
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.lightGreen,
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 65.w,
                                child: Obx(
                                  () => Text(
                                    controller.addressName.value.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Styles.mediumTextBold,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.lightBlue)),
                                  onPressed: () {
                                    Get.to(() => const GoogleMapAdminPage());
                                  },
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          height: 1.h,
                          width: 100.w,
                          color: Colors.grey[200],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          width: 100.w,
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Charts",
                                  style: Styles.header2,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.chartType.value = "Column";
                                      },
                                      child: Obx(
                                        () => Icon(
                                          Icons.bar_chart,
                                          color: controller.chartType.value ==
                                                  'Column'
                                              ? Colors.red[900]
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.chartType.value = "Linear";
                                      },
                                      child: Obx(
                                        () => Icon(
                                          Icons.line_axis,
                                          color: controller.chartType.value ==
                                                  'Linear'
                                              ? Colors.red[900]
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.chartType.value = "Bubble";
                                      },
                                      child: Obx(
                                        () => Icon(
                                          Icons.bubble_chart,
                                          color: controller.chartType.value ==
                                                  'Bubble'
                                              ? Colors.red[900]
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.chartType.value = "Area";
                                      },
                                      child: Obx(
                                        () => Icon(
                                          Icons.area_chart,
                                          color: controller.chartType.value ==
                                                  'Area'
                                              ? Colors.red[900]
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Obx(
                            () => SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(
                                    minimum: 0,
                                    maximum: double.parse(controller
                                        .ordersList.length
                                        .toString()),
                                    interval: 1),
                                series: controller.chartType.value == 'Column'
                                    ? <ChartSeries<ChartData, String>>[
                                        ColumnSeries<ChartData, String>(
                                            dataSource: controller.dataChart,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y,
                                            color: const Color.fromRGBO(
                                                8, 142, 255, 1))
                                      ]
                                    : controller.chartType.value == 'Linear'
                                        ? <ChartSeries<ChartData, String>>[
                                            LineSeries<ChartData, String>(
                                                dataSource:
                                                    controller.dataChart,
                                                xValueMapper:
                                                    (ChartData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartData data, _) =>
                                                        data.y,
                                                color: const Color.fromRGBO(
                                                    8, 142, 255, 1))
                                          ]
                                        : controller.chartType.value == 'Bubble'
                                            ? <ChartSeries<ChartData, String>>[
                                                BubbleSeries<ChartData, String>(
                                                    dataSource:
                                                        controller.dataChart,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y,
                                                    color: const Color.fromRGBO(
                                                        8, 142, 255, 1))
                                              ]
                                            : <ChartSeries<ChartData, String>>[
                                                AreaSeries<ChartData, String>(
                                                    dataSource:
                                                        controller.dataChart,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y,
                                                    color: const Color.fromRGBO(
                                                        8, 142, 255, 1))
                                              ]),
                          ),
                        )),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
