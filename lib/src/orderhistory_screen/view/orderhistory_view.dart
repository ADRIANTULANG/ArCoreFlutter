import 'package:arproject/src/orderhistory_screen/controller/orderhistory_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/textstyles.dart';
import '../../orderdetail_screen/view/orderdetail_view.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderHistoryController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
      ),
      body: SizedBox(
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Obx(
            () => ListView.builder(
              itemCount: controller.orderHistoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const OrderDetailView(), arguments: {
                        "orderDetail": controller.orderHistoryList[index]
                      });
                    },
                    child: Container(
                      height: 15.h,
                      width: 100.w,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 2.w,
                        ),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: controller
                                  .orderHistoryList[index].productimage,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 13.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider)),
                              ),
                              placeholder: (context, url) => SizedBox(
                                height: 13.h,
                                width: 30.w,
                                child: Center(
                                  child: SpinKitThreeBounce(
                                    color: Colors.lightBlue,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => SizedBox(
                                  height: 13.h,
                                  width: 30.w,
                                  child: const Center(
                                    child: Icon(Icons.error),
                                  )),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  width: 54.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          controller.orderHistoryList[index]
                                              .productname,
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.mediumTextBold,
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          "(${controller.orderHistoryList[index].quantity.toString()}x)",
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.mediumTextBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "₱ ${controller.orderHistoryList[index].price.toString()}",
                                  style: Styles.priceText,
                                ),
                                const Expanded(child: SizedBox()),
                                SizedBox(
                                  width: 54.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Status:  ",
                                        style: Styles.mediumTextNormal,
                                      ),
                                      Text(
                                        controller
                                            .orderHistoryList[index].status,
                                        style: Styles.mediumTextBold,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: .5.h,
                                ),
                                SizedBox(
                                  width: 54.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Amount:  ",
                                        style: Styles.mediumTextNormal,
                                      ),
                                      Text(
                                        "₱ ${(controller.orderHistoryList[index].quantity * controller.orderHistoryList[index].price).toStringAsFixed(2)}",
                                        style: Styles.mediumTextBold,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
