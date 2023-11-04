import 'package:arproject/config/textstyles.dart';
import 'package:arproject/src/admin_home_screen/controller/admin_home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.logout),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
      ),
      body: SizedBox(
        child: Obx(
          () => ListView.builder(
            itemCount: controller.productsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                child: SizedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: controller.productsList[index].image,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 15.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: imageProvider)),
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
                            width: 30.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  controller.productsList[index].name,
                                  style: Styles.mediumTextBold,
                                ),
                                Text(
                                  "₱ ${controller.productsList[index].price.toString()}",
                                  style: Styles.priceText,
                                ),
                              ],
                            ),
                          )
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
    );
  }
}
