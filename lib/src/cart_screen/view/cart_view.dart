import 'package:arproject/src/cart_screen/controller/cart_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/textstyles.dart';
import '../../product_screen/view/product_view.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
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
              itemCount: controller.cartList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const ProductView(),
                          arguments: {'product': controller.cartList[index]});
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
                              imageUrl: controller.cartList[index].image,
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
                                  child: Text(
                                    controller.cartList[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    style: Styles.mediumTextBold,
                                  ),
                                ),
                                Text(
                                  "₱ ${controller.cartList[index].price.toString()}",
                                  style: Styles.priceText,
                                ),
                                const Expanded(child: SizedBox()),
                                Container(
                                  height: 5.h,
                                  width: 53.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.red[900],
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5,
                                            spreadRadius: 3,
                                            offset: Offset(1, 2))
                                      ]),
                                  child: Text(
                                    "Buy",
                                    style: Styles.mediumTextBoldWhite,
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
