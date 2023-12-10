import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/admin_payment_proof_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdminPaymentProofView extends GetView<AdminPaymentProofController> {
  const AdminPaymentProofView({super.key, required this.paymentListUrl});
  final List paymentListUrl;
  @override
  Widget build(BuildContext context) {
    Get.put(AdminPaymentProofController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
      ),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: paymentListUrl
                .map((item) => Container(
                      color: Colors.white,
                      height: 100.h,
                      width: 100.w,
                      child: Center(
                          child: Image.network(
                        item,
                        fit: BoxFit.fitWidth,
                        height: height,
                      )),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
