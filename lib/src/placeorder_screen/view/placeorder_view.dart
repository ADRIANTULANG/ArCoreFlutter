import 'dart:io';

import 'package:arproject/src/placeorder_screen/controller/placeorder_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/textstyles.dart';

class PlaceOrderView extends GetView<PlaceOrderController> {
  const PlaceOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlaceOrderController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset('assets/images/logoappbar.png'),
        ),
        body: Obx(() => controller.isLoading.value == true
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
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Product",
                          style: Styles.mediumTextBold,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
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
                                  imageUrl: controller.product.image,
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
                                  errorWidget: (context, url, error) =>
                                      SizedBox(
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
                                      width: 50.w,
                                      child: Text(
                                        controller.product.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.mediumTextBold,
                                      ),
                                    ),
                                    Text(
                                      "₱ ${controller.product.price.toString()}",
                                      style: Styles.priceText,
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.product.quantity.value++;
                                          },
                                          child: Container(
                                            height: 4.h,
                                            width: 9.w,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "+",
                                              style: Styles.mediumTextBold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Container(
                                          height: 4.h,
                                          width: 7.w,
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          alignment: Alignment.center,
                                          child: Obx(
                                            () => Text(
                                              controller.product.quantity.value
                                                  .toString(),
                                              style: Styles.mediumTextBold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (controller
                                                    .product.quantity.value >
                                                1) {
                                              controller
                                                  .product.quantity.value--;
                                            }
                                          },
                                          child: Container(
                                            height: 4.h,
                                            width: 9.w,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "-",
                                              style: Styles.mediumTextBold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
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
                          "Wood Types",
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
                          itemCount: controller.product.woodTypes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: .5.h),
                                  child: Obx(
                                    () => Radio(
                                      groupValue:
                                          controller.groupWoodTypeValue.value,
                                      value:
                                          controller.product.woodTypes[index],
                                      onChanged: (value) {
                                        controller.groupWoodTypeValue.value =
                                            controller.product.woodTypes[index];
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  controller.product.woodTypes[index],
                                  style: Styles.mediumTextNormal,
                                )
                              ],
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
                          "Color Types",
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
                          itemCount: controller.product.colors.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: .5.h),
                                  child: Obx(
                                    () => Radio(
                                      groupValue:
                                          controller.groupColorTypeValue.value,
                                      value: controller.product.colors[index],
                                      onChanged: (value) {
                                        controller.groupColorTypeValue.value =
                                            controller.product.colors[index];
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  controller.product.colors[index],
                                  style: Styles.mediumTextNormal,
                                )
                              ],
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
                          "Delivery Contact Details",
                          style: Styles.mediumTextBold,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w, right: 5.w),
                        child: Text(
                          "Email",
                          style: Styles.mediumTextNormal,
                        ),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        height: 7.h,
                        width: 100.w,
                        child: TextField(
                          controller: controller.email,
                          decoration: InputDecoration(
                              fillColor: Colors.lightBlue[50],
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 3.w),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintStyle: const TextStyle(fontFamily: 'Bariol')),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w, right: 5.w),
                        child: Text(
                          "Contact no.",
                          style: Styles.mediumTextNormal,
                        ),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        height: 7.h,
                        width: 100.w,
                        child: TextField(
                          controller: controller.contactno,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (controller.contactno.text.isEmpty) {
                            } else {
                              if (controller.contactno.text[0] != "9" ||
                                  controller.contactno.text.length > 10) {
                                controller.contactno.clear();
                              } else {}
                            }
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.lightBlue[50],
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 3.w),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintStyle: const TextStyle(fontFamily: 'Bariol')),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w, right: 5.w),
                        child: Text(
                          "Address",
                          style: Styles.mediumTextNormal,
                        ),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        height: 7.h,
                        width: 100.w,
                        child: TextField(
                          controller: controller.address,
                          decoration: InputDecoration(
                              fillColor: Colors.lightBlue[50],
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 3.w),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintStyle: const TextStyle(fontFamily: 'Bariol')),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment Proof",
                              style: Styles.mediumTextBold,
                            ),
                            InkWell(
                              onTap: () {
                                controller.pickImageFromGallery();
                              },
                              child: const Icon(
                                Icons.image_search_rounded,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => controller.proofImageList.isEmpty
                            ? const SizedBox()
                            : SizedBox(
                                height: 13.h,
                                width: 100.w,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 2.w, top: 2.h),
                                  child: Obx(
                                    () => ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.proofImageList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.only(left: 2.w),
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 10.h,
                                                width: 30.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      File(controller
                                                              .proofImageList[
                                                          index]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 1.w,
                                                bottom: 6.h,
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.proofImageList
                                                        .removeAt(index);
                                                  },
                                                  child: Container(
                                                    height: 6.h,
                                                    width: 6.w,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.red),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.clear,
                                                        color: Colors.white,
                                                        size: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
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
                        child: SizedBox(
                          width: 100.w,
                          height: 7.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color.fromARGB(255, 156, 213, 240)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: const BorderSide(
                                            color: Colors.white)))),
                            onPressed: () {
                              if (controller.groupWoodTypeValue.value == '') {
                                Get.snackbar(
                                    "Message", "Please select wood type.",
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              } else if (controller.groupColorTypeValue.value ==
                                  '') {
                                Get.snackbar(
                                    "Message", "Please select color type.",
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              } else if (controller.proofImageList.isEmpty) {
                                Get.snackbar("Message",
                                    "Please upload atleast one payment proof.",
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              } else if (controller.email.text.isEmail ==
                                  false) {
                                Get.snackbar("Message", "Invalid email format.",
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              } else if (controller.email.text.isEmpty ||
                                  controller.address.text.isEmpty ||
                                  controller.contactno.text.isEmpty) {
                                Get.snackbar(
                                    "Message", "Missing contact details info.",
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              } else if (controller.contactno.text.length !=
                                  10) {
                                Get.snackbar(
                                    "Message", "Incorrect contact no. format.",
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              } else {
                                controller.placeOrder();
                              }
                            },
                            child: Text("PLACE ORDER", style: Styles.header1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                    ],
                  ),
                ),
              )));
  }
}
