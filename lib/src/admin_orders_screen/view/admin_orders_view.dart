import 'package:arproject/config/textstyles.dart';
import 'package:arproject/services/getstorage_services.dart';
import 'package:arproject/src/admin_orders_screen/controller/admin_orders_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../admin_home_screen/widget/alertdialogs.dart';
import '../../admin_orderdetail_screen/view/admin_orderdetail_view.dart';
import '../../admin_payment_proof_screen/view/admin_payment_proof_view.dart';
import '../../admin_report_screen/view/admin_report_view.dart';

class AdminOrderView extends GetView<AdminOrderController> {
  const AdminOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              AdminHomeScreenAlertDialog.showLogoutConfirmation();
            },
            child: const Icon(Icons.logout)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const AdminReportView());
            },
            child: Icon(
              Icons.insert_chart,
              color: Colors.red[900],
            ),
          ),
          SizedBox(
            width: 4.w,
          )
        ],
      ),
      body: Get.find<StorageServices>().storage.read('usertype') == "Seller"
          ? SizedBox(
              child: Center(
                child: Text(
                  "You dont have permission to view this page.",
                  style: Styles.mediumTextNormal,
                ),
              ),
            )
          : SizedBox(
              height: 100.h,
              width: 100.w,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 7.h,
                      width: 100.w,
                      child: TextField(
                        controller: controller.search,
                        onChanged: (value) {
                          if (controller.search.text.isEmpty) {
                            controller.ordersList
                                .assignAll(controller.ordersListMasterList);
                          } else {}
                          controller.searchProduct(word: value);
                        },
                        decoration: InputDecoration(
                            // fillColor: Colors.lightBlue[50],
                            // filled: true,
                            contentPadding: EdgeInsets.only(left: 3.w),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Search Order',
                            hintStyle: const TextStyle(fontFamily: 'Bariol')),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          itemCount: controller.ordersList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 1.h,
                                    bottom: 1.h,
                                    left: 1.w,
                                    right: 1.w),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: controller
                                            .ordersList[index].productimage,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 20.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: imageProvider)),
                                        ),
                                        placeholder: (context, url) => SizedBox(
                                          child: Center(
                                            child: SpinKitThreeBounce(
                                              color: Colors.lightBlue,
                                              size: 25.sp,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const SizedBox(
                                                child: Center(
                                          child: Icon(Icons.error),
                                        )),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Tracking Code: ",
                                            style: Styles.mediumTextNormal,
                                          ),
                                          Text(
                                            controller.ordersList[index].id,
                                            style: Styles.mediumTextBold,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            controller
                                                .ordersList[index].productname,
                                            style: Styles.mediumTextBold,
                                          ),
                                          Text(
                                            " ${controller.ordersList[index].quantity.toString()} pcs.",
                                            style: Styles.mediumTextBold,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "₱ ${controller.ordersList[index].price.toString()}",
                                        style: Styles.priceText,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      controller.ordersList[index].status ==
                                              'Pending'
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.updateOrder(
                                                        fcmToken: controller
                                                            .ordersList[index]
                                                            .customerDetails
                                                            .fcmToken,
                                                        ordeID: controller
                                                            .ordersList[index]
                                                            .id,
                                                        status: "Accepted");
                                                  },
                                                  child: Container(
                                                    height: 7.h,
                                                    width: 40.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: Colors.white),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 5,
                                                            spreadRadius: 3,
                                                            offset:
                                                                Offset(1, 2))
                                                      ],
                                                      color: Colors.green,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "ACCEPT",
                                                      style: Styles
                                                          .mediumTextBoldWhite,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    controller.updateOrder(
                                                        fcmToken: controller
                                                            .ordersList[index]
                                                            .customerDetails
                                                            .fcmToken,
                                                        ordeID: controller
                                                            .ordersList[index]
                                                            .id,
                                                        status: "Cancelled");
                                                  },
                                                  child: Container(
                                                    height: 7.h,
                                                    width: 40.w,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              blurRadius: 5,
                                                              spreadRadius: 3,
                                                              offset:
                                                                  Offset(1, 2))
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Colors.red[900]),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "DECLINE",
                                                      style: Styles
                                                          .mediumTextBoldWhite,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : controller.ordersList[index]
                                                      .status ==
                                                  'Cancelled'
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 3.w, right: 3.w),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 7.h,
                                                      width: 100.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              blurRadius: 5,
                                                              spreadRadius: 3,
                                                              offset:
                                                                  Offset(1, 2))
                                                        ],
                                                        color: Colors.grey,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "CANCELLED",
                                                        style: Styles
                                                            .mediumTextBold,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 3.w, right: 3.w),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                          () =>
                                                              const AdminOrderDetailView(),
                                                          arguments: {
                                                            'orderDetail':
                                                                controller
                                                                        .ordersList[
                                                                    index]
                                                          });
                                                    },
                                                    child: Container(
                                                      height: 7.h,
                                                      width: 100.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              blurRadius: 5,
                                                              spreadRadius: 3,
                                                              offset:
                                                                  Offset(1, 2))
                                                        ],
                                                        color: Colors
                                                            .lightBlue[100],
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "VIEW ORDER",
                                                        style: Styles
                                                            .mediumTextBold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 3.w, right: 3.w),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => AdminPaymentProofView(
                                                paymentListUrl: controller
                                                    .ordersList[index]
                                                    .proofPaymentUrlList,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 7.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.white),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 5,
                                                    spreadRadius: 3,
                                                    offset: Offset(1, 2))
                                              ],
                                              color: Colors.lightBlue[100],
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "VIEW PAYMENT PROOFS",
                                              style: Styles.mediumTextBold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
