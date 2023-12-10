import 'dart:async';

import 'package:arproject/src/appdrawer_screen/drawer_view.dart';
import 'package:arproject/src/home_screen/controller/home_controller.dart';
import 'package:arproject/src/search_screen/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/textstyles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:badges/badges.dart' as badges;
import '../../cart_screen/view/cart_view.dart';
import '../../product_screen/view/product_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
        actions: [
          Obx(
            () => controller.cartCount.value > 0
                ? Padding(
                    padding: EdgeInsets.only(top: 1.6.h),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => const CartView());
                        },
                        child: badges.Badge(
                            badgeContent:
                                Text(controller.cartCount.value.toString()),
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
      body: Obx(
        () => controller.isLoading.value == true
            ? SizedBox(
                child: Center(
                  child: SpinKitThreeBounce(
                    color: Colors.lightBlue,
                    size: 35.sp,
                  ),
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  controller.getProducts();
                },
                child: SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          height: 7.h,
                          width: 100.w,
                          child: TextField(
                            controller: controller.search,
                            onChanged: (value) {
                              if (controller.debounce?.isActive ?? false) {
                                controller.debounce!.cancel();
                              }
                              controller.debounce =
                                  Timer(const Duration(milliseconds: 1000), () {
                                if (controller.search.text.isNotEmpty) {
                                  Get.to(() => const SearchView(), arguments: {
                                    'word': controller.search.text,
                                    'products': controller.productListAll
                                  });
                                  controller.search.clear();
                                  FocusScope.of(context).unfocus();
                                }
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 3.w),
                                alignLabelWithHint: false,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                hintText: 'Search Product',
                                hintStyle:
                                    const TextStyle(fontFamily: 'Bariol')),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          height: 25.h,
                          width: 100.w,
                          child: Obx(
                            () => ListView.builder(
                              itemCount: controller.productListNew.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(left: 3.w, right: 3.w),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => const ProductView(),
                                          arguments: {
                                            'product':
                                                controller.productListNew[index]
                                          });
                                    },
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: controller
                                              .productListNew[index].image,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 25.h,
                                            width: 94.w,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: imageProvider)),
                                          ),
                                          placeholder: (context, url) =>
                                              SizedBox(
                                            height: 25.h,
                                            width: 94.w,
                                            child: Center(
                                              child: SpinKitThreeBounce(
                                                color: Colors.lightBlue,
                                                size: 25.sp,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              SizedBox(
                                                  height: 25.h,
                                                  width: 94.w,
                                                  child: const Center(
                                                    child: Icon(Icons.error),
                                                  )),
                                        ),
                                        controller
                                                    .getRates(
                                                        ratings: controller
                                                            .productListNew[
                                                                index]
                                                            .rate)
                                                    .value ==
                                                "0"
                                            ? const SizedBox()
                                            : Positioned(
                                                right: 3.w,
                                                top: 1.h,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: .2.h,
                                                      bottom: .2.h,
                                                      left: 1.w,
                                                      right: 1.w),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        controller
                                                            .getRates(
                                                                ratings: controller
                                                                    .productListNew[
                                                                        index]
                                                                    .rate)
                                                            .value,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 11.sp,
                                                            fontFamily:
                                                                'Bariol'),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                        size: 15.sp,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 3.w,
                                  child: const Divider(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                "New Furniture",
                                style: Styles.mediumTextBold,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 3.w,
                                  child: const Divider(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Obx(
                              () => GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.8,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10),
                                itemCount: controller.productListAll.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => const ProductView(),
                                          arguments: {
                                            'product':
                                                controller.productListAll[index]
                                          });
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                  imageUrl: controller
                                                      .productListAll[index]
                                                      .image,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    imageProvider)),
                                                      ),
                                                  placeholder: (context, url) =>
                                                      SizedBox(
                                                        child: Center(
                                                          child:
                                                              SpinKitThreeBounce(
                                                            color: Colors
                                                                .lightBlue,
                                                            size: 25.sp,
                                                          ),
                                                        ),
                                                      ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const SizedBox(
                                                          child: Center(
                                                        child:
                                                            Icon(Icons.error),
                                                      ))),
                                              controller
                                                          .getRates(
                                                              ratings: controller
                                                                  .productListAll[
                                                                      index]
                                                                  .rate)
                                                          .value ==
                                                      "0"
                                                  ? const SizedBox()
                                                  : Positioned(
                                                      right: 3.w,
                                                      top: 1.h,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: .2.h,
                                                                bottom: .2.h,
                                                                left: 1.w,
                                                                right: 1.w),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color:
                                                                Colors.white),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              controller
                                                                  .getRates(
                                                                      ratings: controller
                                                                          .productListAll[
                                                                              index]
                                                                          .rate)
                                                                  .value,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      11.sp,
                                                                  fontFamily:
                                                                      'Bariol'),
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.yellow,
                                                              size: 15.sp,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          controller.productListAll[index].name,
                                          style: Styles.mediumTextBold,
                                        ),
                                        Text(
                                          "₱ ${controller.productListAll[index].price.toString()}",
                                          style: Styles.priceText,
                                        ),
                                        Text(
                                          "Stocks: ${controller.productListAll[index].stocks.toString()}",
                                          style: Styles.smalltextGrey,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}


// name
// images
// price
// isNew
// description
// specifications
