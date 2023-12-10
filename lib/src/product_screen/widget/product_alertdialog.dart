import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/product_controller.dart';

class ProductScreenAlertDialog {
  static showRating({required ProductController controller}) async {
    RxString rate = '3.0'.obs;
    TextEditingController comment = TextEditingController();
    Get.dialog(AlertDialog(
        actions: [
          TextButton(
              onPressed: () {
                controller.addRating(
                    rate: double.parse(rate.value), comment: comment.text);
              },
              child: const Text("Done"))
        ],
        content: Container(
          height: 35.h,
          width: 100.w,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Text(
                "How would you rate this product?",
                style: TextStyle(
                    fontFamily: 'Bariol',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: Colors.black),
              ),
              SizedBox(
                height: 2.h,
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.only(left: 1.w),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  rate.value = rating.toString();
                },
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Text(
                "Describe your experience about this product (Optional)",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bariol',
                    fontSize: 13.sp,
                    color: Colors.black),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              SizedBox(
                height: 13.h,
                width: 100.w,
                child: TextField(
                  controller: comment,
                  maxLines: 5,
                  decoration: InputDecoration(
                      fillColor: Colors.lightBlue[50],
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w, top: 2.h),
                      alignLabelWithHint: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3)),
                      hintStyle: const TextStyle(fontFamily: 'Bariol')),
                ),
              ),
            ],
          ),
        )));
  }
}
