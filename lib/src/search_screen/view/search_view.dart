import 'dart:async';

import 'package:arproject/src/search_screen/controller/search_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/textstyles.dart';
import '../../product_screen/view/product_view.dart';

class SearchView extends GetView<SearchProductController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchProductController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
      ),
      body: SizedBox(
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
                      controller.searchProduct(word: controller.search.text);
                    } else {
                      controller.productList
                          .assignAll(controller.productListMasterList);
                    }
                  });
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 3.w),
                    alignLabelWithHint: false,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Search Product',
                    hintStyle: const TextStyle(fontFamily: 'Bariol')),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const ProductView(), arguments: {
                            'product': controller.productList[index]
                          });
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        controller.productList[index].image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 15.h,
                                      width: 30.w,
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
                                    width: 1.w,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                    width: 55.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.productList[index].name,
                                          style: Styles.mediumTextBold,
                                        ),
                                        Text(
                                          "₱ ${controller.productList[index].price.toString()}",
                                          style: Styles.priceText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider()
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
