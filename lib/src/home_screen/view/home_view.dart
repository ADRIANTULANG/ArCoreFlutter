import 'package:arproject/src/home_screen/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../arnew_view.dart';
import '../../../config/textstyles.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          const Icon(Icons.shopping_bag_outlined),
          SizedBox(
            width: 5.w,
          )
        ],
      ),
      drawer: const Drawer(),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        child: InkWell(
                          onTap: () {
                            // Get.to(() => const MyWidget());
                            Get.to(() => const LocalAndWebObjectsWidget());
                          },
                          child: CachedNetworkImage(
                            imageUrl: controller.productListNew[index].image,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 25.h,
                              width: 94.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: imageProvider)),
                            ),
                            placeholder: (context, url) => SizedBox(
                              height: 25.h,
                              width: 94.w,
                              child: Center(
                                child: SpinKitThreeBounce(
                                  color: Colors.lightBlue,
                                  size: 25.sp,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => SizedBox(
                                height: 25.h,
                                width: 94.w,
                                child: const Center(
                                  child: Icon(Icons.error),
                                )),
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
                              childAspectRatio: 0.9,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemCount: controller.productListAll.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl:
                                    controller.productListAll[index].image,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                          ],
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
    );
  }
}


// name
// images
// price
// isNew
// description
// specifications
