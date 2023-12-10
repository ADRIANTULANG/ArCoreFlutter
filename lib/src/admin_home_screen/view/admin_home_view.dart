import 'package:arproject/config/textstyles.dart';
import 'package:arproject/src/admin_home_screen/controller/admin_home_controller.dart';
import 'package:arproject/src/admin_home_screen/widget/alertdialogs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../admin_editproducts_screen/view/admin_editproducts_view.dart';
import '../../admin_report_screen/view/admin_report_view.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({super.key});

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
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getProducts();
        },
        child: SizedBox(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                height: 7.h,
                width: 100.w,
                child: TextField(
                  controller: controller.search,
                  onChanged: (value) {
                    if (controller.search.text.isEmpty) {
                      controller.productsList
                          .assignAll(controller.productsListMasterList);
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
                      hintText: 'Search products',
                      hintStyle: const TextStyle(fontFamily: 'Bariol')),
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.productsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                        child: SizedBox(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        controller.productsList[index].image,
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
                                          controller.productsList[index].name,
                                          style: Styles.mediumTextBold,
                                        ),
                                        Text(
                                          "₱ ${controller.productsList[index].price.toString()}",
                                          style: Styles.priceText,
                                        ),
                                        Text(
                                          "Stocks: ${controller.productsList[index].stocks.toString()}",
                                          style: Styles.smalltext,
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: SizedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                          () =>
                                                              const AdminEditProductsView(),
                                                          arguments: {
                                                            "productID":
                                                                controller
                                                                    .productsList[
                                                                        index]
                                                                    .id,
                                                            "imageLink":
                                                                controller
                                                                    .productsList[
                                                                        index]
                                                                    .image,
                                                            "modelLink":
                                                                controller
                                                                    .productsList[
                                                                        index]
                                                                    .arFile,
                                                            "productname":
                                                                controller
                                                                    .productsList[
                                                                        index]
                                                                    .name,
                                                            "productprice":
                                                                controller
                                                                    .productsList[
                                                                        index]
                                                                    .price
                                                                    .toString(),
                                                            "productdescription":
                                                                controller
                                                                    .productsList[
                                                                        index]
                                                                    .description,
                                                            "woodTypesList":
                                                                controller
                                                                    .productsList[
                                                                        index]
                                                                    .woodTypes,
                                                            "specificationList":
                                                                controller
                                                                    .productsList[
                                                                        index]
                                                                    .specifications,
                                                            "colorTypesList":
                                                                controller
                                                                    .productsList[
                                                                        index]
                                                                    .colors,
                                                            "stocks": controller
                                                                .productsList[
                                                                    index]
                                                                .stocks,
                                                          });
                                                    },
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      AdminHomeScreenAlertDialog
                                                          .showDeleteProduct(
                                                        controller: controller,
                                                        productID: controller
                                                            .productsList[index]
                                                            .id,
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider()
                            ],
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
      ),
    );
  }
}
