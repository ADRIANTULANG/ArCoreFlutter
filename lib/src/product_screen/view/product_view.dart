import 'package:arproject/services/authentication_services.dart';
import 'package:arproject/src/login_screen/view/login_view.dart';
import 'package:arproject/src/product_screen/controller/product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../config/textstyles.dart';
import '../../ar_screen/ar_view.dart';
import '../../placeorder_screen/view/placeorder_view.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 2.3.h),
            child: InkWell(
              onTap: () {
                if (Get.find<AuthenticationService>().hasVerifiedUser.value) {
                  controller.saveToCart();
                } else {
                  Get.to(() => const LoginView());
                }
              },
              child: FaIcon(
                FontAwesomeIcons.cartPlus,
                color: Colors.red[900],
                size: 17.sp,
              ),
            ),
          ),
          // SizedBox(
          //   width: 3.w,
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: 2.3.h),
          //   child: InkWell(
          //     onTap: () {
          //       if (Get.find<AuthenticationService>().hasVerifiedUser.value) {
          //         ProductScreenAlertDialog.showRating(controller: controller);
          //       } else {
          //         Get.to(() => const LoginView());
          //       }
          //     },
          //     child: FaIcon(
          //       FontAwesomeIcons.trophy,
          //       color: Colors.yellow,
          //       size: 17.sp,
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 5.w,
          ),
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
                    size: 50.sp,
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
                              imageUrl: controller.product.image,
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
                            Positioned(
                              top: 1.h,
                              left: 1.w,
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ARview(
                                      urlModel: controller.product.arFile));
                                },
                                child: Container(
                                  height: 4.h,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.lightBlue[200]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera,
                                        size: 15.sp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "AR",
                                        style: Styles.mediumTextBoldWhite,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            controller
                                        .getRates(
                                            ratings: controller.product.rate)
                                        .value ==
                                    "0"
                                ? const SizedBox()
                                : Positioned(
                                    top: 1.h,
                                    left: 18.w,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => ARview(
                                            urlModel:
                                                controller.product.arFile));
                                      },
                                      child: Container(
                                        height: 4.h,
                                        width: 15.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Obx(
                                              () => Text(
                                                controller
                                                    .getRates(
                                                        ratings: controller
                                                            .product.rate)
                                                    .value,
                                                style: Styles.mediumTextBold,
                                              ),
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 15.sp,
                                              color: Colors.yellow,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          controller.product.name,
                          style: Styles.header1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "₱ ${controller.product.price.toString()}",
                          style: Styles.priceText,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Stocks: ${controller.product.stocks.toString()} pcs.",
                          style: Styles.smalltextGrey,
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
                          "Description",
                          style: Styles.mediumTextBold,
                        ),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          controller.product.description,
                          style: Styles.mediumTextNormal,
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
                          "Specifications",
                          style: Styles.mediumTextBold,
                        ),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.product.specifications.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: .5.h),
                                    child: Icon(
                                      Icons.circle,
                                      size: 10.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.product.specifications[index],
                                      style: Styles.mediumTextNormal,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
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
                          "Ratings & Comments",
                          style: Styles.mediumTextBold,
                        ),
                      ),
                      controller.product.rate.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.product.rate.length,
                                itemBuilder:
                                    (BuildContext context, int rateindex) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 1.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 10.h,
                                              width: 10.w,
                                              decoration: const BoxDecoration(
                                                  color: Colors.lightBlue,
                                                  shape: BoxShape.circle),
                                              child: Center(
                                                child: Text(
                                                  controller
                                                      .product
                                                      .rate[rateindex]
                                                      .email[0]
                                                      .capitalizeFirst
                                                      .toString(),
                                                  style: Styles
                                                      .mediumTextBoldWhite,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller.product
                                                      .rate[rateindex].email,
                                                  style:
                                                      Styles.mediumTextNormal,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      controller.product
                                                          .rate[rateindex].rate
                                                          .toString(),
                                                      style: Styles
                                                          .mediumTextNormal,
                                                    ),
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 11.sp,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.w, right: 5.w),
                                          child: Text(
                                            controller.product.rate[rateindex]
                                                .comment,
                                            style: Styles.mediumTextNormal,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : SizedBox(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Text(
                                    "No comments or reviews for this product.",
                                    style: Styles.mediumTextNormal,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        onPressed: () {
          if (Get.find<AuthenticationService>().hasVerifiedUser.value) {
            Get.to(() => const PlaceOrderView(),
                arguments: {'product': controller.product});
          } else {
            Get.to(() => const LoginView());
          }
        },
        child: const Icon(
          Icons.shopping_bag_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
