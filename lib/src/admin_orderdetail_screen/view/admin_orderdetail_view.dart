import 'package:arproject/src/admin_orderdetail_screen/controller/admin_orderdetail_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/textstyles.dart';
import '../../admin_chat_screen/view/admin_chat_view.dart';

class AdminOrderDetailView extends GetView<AdminOrderDetailController> {
  const AdminOrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminOrderDetailController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const AdminChatView(), arguments: {
                "orderID": controller.orderDetail.id,
                "customerUserID": controller.orderDetail.customerDetails.userid,
                "customerDocumentID":
                    controller.orderDetail.customerDetails.documentID,
              });
            },
            child: const Icon(
              Icons.messenger,
              color: Colors.green,
            ),
          ),
          SizedBox(
            width: 5.w,
          )
        ],
      ),
      body: Obx(
        () => controller.isLoading.value == true
            ? SizedBox(
                height: 100.h,
                width: 100.w,
                child: Center(
                  child: SpinKitThreeBounce(
                    color: Colors.lightBlue,
                    size: 30.sp,
                  ),
                ),
              )
            : SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: controller.orderDetail.productimage,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 33.h,
                                width: 94.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider)),
                              ),
                              placeholder: (context, url) => SizedBox(
                                height: 33.h,
                                width: 94.w,
                                child: Center(
                                  child: SpinKitThreeBounce(
                                    color: Colors.lightBlue,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => SizedBox(
                                  height: 33.h,
                                  width: 94.w,
                                  child: const Center(
                                    child: Icon(Icons.error),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 1.5.h,
                        width: 100.w,
                        color: Colors.grey[200],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Ordered Product Details",
                          style: Styles.header3,
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
                                  "Tracking code: ",
                                  style: Styles.mediumTextNormal,
                                ),
                                Text(
                                  controller.orderDetail.id,
                                  style: Styles.mediumTextBold,
                                ),
                              ],
                            ),
                            InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: controller.orderDetail.id));
                                },
                                child: const Icon(Icons.copy))
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         "Reference no: ",
                      //         style: Styles.mediumTextNormal,
                      //       ),
                      //       Text(
                      //         controller.orderDetail.referenceNo,
                      //         style: Styles.mediumTextBold,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Product name: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              controller.orderDetail.productname,
                              style: Styles.mediumTextBold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Product price: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              "₱ ${controller.orderDetail.price.toString()}",
                              style: Styles.priceText,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Shipping fee: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              "₱ ${controller.orderDetail.shippingfee.toStringAsFixed(2)}",
                              style: Styles.priceText,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Sub-total: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              "₱ ${(controller.orderDetail.price * controller.orderDetail.quantity).toStringAsFixed(2)}",
                              style: Styles.priceText,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Total: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              "₱ ${((controller.orderDetail.price * controller.orderDetail.quantity) + controller.orderDetail.shippingfee).toStringAsFixed(2)}",
                              style: Styles.priceText,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Order quantity: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              "${controller.orderDetail.quantity.toString()} pcs.",
                              style: Styles.mediumTextBold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Wood type: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              controller.orderDetail.woodType,
                              style: Styles.mediumTextBold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Color: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              controller.orderDetail.color,
                              style: Styles.mediumTextBold,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 1.5.h,
                        width: 100.w,
                        color: Colors.grey[200],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Delivery Details",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Address to deliver: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Expanded(
                              child: Text(
                                controller.orderDetail.userAddress,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.mediumTextBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "email: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Expanded(
                              child: Text(
                                controller.orderDetail.userEmail,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.mediumTextBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Contact no: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              controller.orderDetail.userContactno,
                              style: Styles.mediumTextBold,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 1.5.h,
                        width: 100.w,
                        color: Colors.grey[200],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Customer Details",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Customer name: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              "${controller.orderDetail.customerDetails.firstname} ${controller.orderDetail.customerDetails.lastname}",
                              style: Styles.mediumTextBold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Email: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              controller.orderDetail.customerDetails.email,
                              style: Styles.mediumTextBold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Address: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              controller.orderDetail.customerDetails.address,
                              style: Styles.mediumTextBold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Contact no: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Text(
                              controller.orderDetail.customerDetails.contactno,
                              style: Styles.mediumTextBold,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 1.5.h,
                        width: 100.w,
                        color: Colors.grey[200],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Order Status",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Text(
                              "Status: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Obx(
                              () => Text(
                                controller.orderStatus.value,
                                style: Styles.mediumTextBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        child: InkWell(
                          onTap: () {
                            controller.updateOrder(
                                token: controller
                                    .orderDetail.customerDetails.fcmToken,
                                ordeID: controller.orderDetail.id,
                                status: controller.orderDetail.status);
                          },
                          child: Container(
                            height: 7.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white),
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
                              "UPDATE ORDER",
                              style: Styles.mediumTextBold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
