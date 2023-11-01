import 'package:arproject/src/product_screen/controller/product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../config/textstyles.dart';
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
            child: FaIcon(
              FontAwesomeIcons.cartPlus,
              color: Colors.red[900],
              size: 17.sp,
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
                        child: CachedNetworkImage(
                          imageUrl: controller.product.image,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 33.h,
                            width: 94.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider)),
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
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        onPressed: () {
          Get.to(() => const PlaceOrderView(),
              arguments: {'product': controller.product});
        },
        child: const Icon(
          Icons.shopping_bag_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
