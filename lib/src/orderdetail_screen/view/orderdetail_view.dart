import 'package:arproject/src/chat_screen/view/chat_view.dart';
import 'package:arproject/src/orderdetail_screen/controller/orderdetail_controller.dart';
import 'package:arproject/src/orderdetail_screen/widget/orderdetail_alertdialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/textstyles.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const ChatView(),
                  arguments: {"orderID": controller.orderDetail.id});
            },
            child: const Icon(
              Icons.messenger,
              color: Colors.green,
            ),
          ),
          Obx(
            () => controller.showRatingButton.value
                ? SizedBox(
                    width: 3.w,
                  )
                : const SizedBox(),
          ),
          Obx(
            () => controller.showRatingButton.value
                ? Padding(
                    padding: EdgeInsets.only(top: 2.3.h),
                    child: InkWell(
                      onTap: () {
                        OrderDetailScreenAlertDialog.showRating(
                            controller: controller);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.trophy,
                        color: Colors.yellow,
                        size: 17.sp,
                      ),
                    ),
                  )
                : const SizedBox(),
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
                            Text(
                              controller.orderDetail.status,
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
                              "Contact no: ",
                              style: Styles.mediumTextNormal,
                            ),
                            Expanded(
                              child: Text(
                                controller.orderDetail.userContactno,
                                style: Styles.mediumTextBold,
                              ),
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
                        child: SizedBox(
                          width: 100.w,
                          height: 7.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color.fromARGB(255, 156, 213, 240)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: const BorderSide(
                                            color: Colors.white)))),
                            onPressed: () {
                              controller.reOrder(
                                  productID: controller.orderDetail.productID);
                            },
                            child: Text("RE-ORDER", style: Styles.header1),
                          ),
                        ),
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
