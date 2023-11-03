import 'package:arproject/src/cart_screen/view/cart_view.dart';
import 'package:arproject/src/home_screen/controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;
import '../../../config/textstyles.dart';
import '../../appdrawer_screen/drawer_view.dart';
import '../controller/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
        actions: [
          Obx(
            () => Get.find<HomeController>().cartCount.value > 0
                ? Padding(
                    padding: EdgeInsets.only(top: 1.6.h),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => const CartView());
                        },
                        child: badges.Badge(
                            badgeContent: Text(Get.find<HomeController>()
                                .cartCount
                                .value
                                .toString()),
                            child: const Icon(Icons.shopping_bag_outlined))),
                  )
                : InkWell(
                    onTap: () {
                      Get.to(() => const CartView());
                    },
                    child: const Icon(Icons.shopping_bag_outlined)),
          ),
          SizedBox(
            width: 5.w,
          )
        ],
      ),
      drawer: AppDrawer.showAppDrawer(),
      body: SizedBox(
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Obx(
            () => ListView.builder(
              itemCount: controller.orderList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(top: 1.h),
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
                            imageUrl: controller.orderList[index].productimage,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 13.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: imageProvider)),
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
                                        controller.orderList[index].productname,
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.mediumTextBold,
                                      ),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "(${controller.orderList[index].quantity.toString()}x)",
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.mediumTextBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "₱ ${controller.orderList[index].price.toString()}",
                                style: Styles.priceText,
                              ),
                              const Expanded(child: SizedBox()),
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
                                      "₱ ${(controller.orderList[index].quantity * controller.orderList[index].price).toStringAsFixed(2)}",
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
