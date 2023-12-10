import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/textstyles.dart';
import '../controller/admin_editproducts_controller.dart';

class AdminEditProductsView extends GetView<AdminEditProductsController> {
  const AdminEditProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminEditProductsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
      ),
      body: Obx(
        () => controller.isEditing.value == true
            ? SizedBox(
                height: 100.h,
                width: 100.w,
                child: Center(
                  child: SpinKitThreeBounce(
                    color: Colors.lightBlue,
                    size: 30.sp,
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
                        child: Text(
                          "Product image",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      InkWell(
                        onTap: () {
                          controller.getImage();
                        },
                        child: Obx(
                          () => controller.filename.value == ''
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  child: Container(
                                    height: 30.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                controller.imageLink.value))),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  child: Container(
                                    height: 30.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                                controller.pickedImage!))),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Product AR File",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: InkWell(
                          onTap: () {
                            controller.getArFile();
                          },
                          child: Obx(
                            () => Container(
                              height: 10.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: controller.arString.value ==
                                          "3D Model Selected"
                                      ? Colors.lightBlue[50]
                                      : Colors.white),
                              alignment: Alignment.center,
                              child: Obx(
                                () => Text(
                                  controller.arString.value,
                                  style: Styles.mediumTextBold,
                                ),
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
                        child: Text(
                          "Product name",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        height: 7.h,
                        width: 100.w,
                        child: TextField(
                          controller: controller.productname,
                          decoration: InputDecoration(
                              fillColor: Colors.lightBlue[50],
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 3.w),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: 'Name',
                              hintStyle: const TextStyle(fontFamily: 'Bariol')),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Product price",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        height: 7.h,
                        width: 100.w,
                        child: TextField(
                          controller: controller.productprice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              fillColor: Colors.lightBlue[50],
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 3.w),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: 'Price',
                              hintStyle: const TextStyle(fontFamily: 'Bariol')),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Product stocks",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        height: 7.h,
                        width: 100.w,
                        child: TextField(
                          controller: controller.stocks,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              fillColor: Colors.lightBlue[50],
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 3.w),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: 'Stocks',
                              hintStyle: const TextStyle(fontFamily: 'Bariol')),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Product description",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        height: 18.h,
                        width: 100.w,
                        child: TextField(
                          controller: controller.productdescription,
                          maxLines: 20,
                          decoration: InputDecoration(
                              fillColor: Colors.lightBlue[50],
                              filled: true,
                              contentPadding:
                                  EdgeInsets.only(left: 3.w, top: 2.h),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: 'Description',
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
                        child: Text(
                          "Wood Types",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: SizedBox(
                          height: 7.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 6.h,
                                width: 70.w,
                                child: TextField(
                                  controller: controller.woodText,
                                  decoration: InputDecoration(
                                    fillColor: Colors.lightBlue[50],
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                      left: 3.w,
                                    ),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.woodTypesList.add(controller
                                      .woodText.text.capitalizeFirst
                                      .toString());
                                  controller.woodText.clear();
                                },
                                child: Container(
                                    height: 6.h,
                                    width: 15.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Icon(Icons.add)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Obx(
                          () => controller.woodTypesList.isEmpty
                              ? const SizedBox()
                              : SizedBox(
                                  height: 7.h,
                                  width: 100.w,
                                  child: Obx(
                                    () => ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.woodTypesList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.only(right: 2.w),
                                          child: InkWell(
                                            onTap: () {
                                              controller.woodTypesList
                                                  .removeAt(index);
                                            },
                                            child: Chip(
                                              backgroundColor:
                                                  Colors.lightBlue[100],
                                              avatar: const CircleAvatar(
                                                backgroundColor: Colors.red,
                                                child: Icon(Icons.clear),
                                              ),
                                              label: Text(controller
                                                  .woodTypesList[index]),
                                            ),
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
                        child: Text(
                          "Color Types",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: SizedBox(
                          height: 7.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 6.h,
                                width: 70.w,
                                child: TextField(
                                  controller: controller.colorText,
                                  decoration: InputDecoration(
                                    fillColor: Colors.lightBlue[50],
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                      left: 3.w,
                                    ),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.colorTypesList.add(controller
                                      .colorText.text.capitalizeFirst
                                      .toString());
                                  controller.colorText.clear();
                                },
                                child: Container(
                                    height: 6.h,
                                    width: 15.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Icon(Icons.add)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Obx(
                          () => controller.colorTypesList.isEmpty
                              ? const SizedBox()
                              : SizedBox(
                                  height: 7.h,
                                  width: 100.w,
                                  child: Obx(
                                    () => ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.colorTypesList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.only(right: 2.w),
                                          child: InkWell(
                                            onTap: () {
                                              controller.colorTypesList
                                                  .removeAt(index);
                                            },
                                            child: Chip(
                                              backgroundColor:
                                                  Colors.lightBlue[100],
                                              avatar: const CircleAvatar(
                                                backgroundColor: Colors.red,
                                                child: Icon(Icons.clear),
                                              ),
                                              label: Text(controller
                                                  .colorTypesList[index]),
                                            ),
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
                        child: Text(
                          "Specifications",
                          style: Styles.header3,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: SizedBox(
                          child: Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.specificationList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          controller.specificationList[index],
                                          style: Styles.mediumTextNormal,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.specificationList
                                              .removeAt(index);
                                        },
                                        child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              Icons.clear,
                                              color: Colors.white,
                                              size: 15.sp,
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: SizedBox(
                          height: 7.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 6.h,
                                width: 70.w,
                                child: TextField(
                                  controller: controller.specificationText,
                                  decoration: InputDecoration(
                                    fillColor: Colors.lightBlue[50],
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                      left: 3.w,
                                    ),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.specificationList.add(controller
                                      .specificationText.text.capitalizeFirst
                                      .toString());
                                  controller.specificationText.clear();
                                },
                                child: Container(
                                    height: 6.h,
                                    width: 15.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Icon(Icons.add)),
                              ),
                            ],
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
                              if (controller.productname.text.isEmpty ||
                                  controller.productdescription.text.isEmpty ||
                                  controller.productprice.text.isEmpty) {
                                Get.snackbar("Message", "Missing product info",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              } else if (controller.woodTypesList.isEmpty) {
                                Get.snackbar("Message",
                                    "Please input at least 1 wood type",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              } else if (controller.colorTypesList.isEmpty) {
                                Get.snackbar("Message",
                                    "Please input at least 1 color type",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              } else if (controller.specificationList.isEmpty) {
                                Get.snackbar("Message",
                                    "Please input at least 1 product specification.",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              } else {
                                controller.updateProducts();
                              }
                            },
                            child:
                                Text("UPDATE PRODUCT", style: Styles.header1),
                          ),
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
    );
  }
}
