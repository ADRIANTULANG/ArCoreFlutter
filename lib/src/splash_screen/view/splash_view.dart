import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/blurlightsnew.jpg'))),
          ),
          SizedBox(
            height: 25.h,
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Image.asset('assets/images/arimage.png'),
            ),
          ),
          Positioned(
            top: 52.h,
            child: Container(
              height: 8.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/modspace.png'))),
            ),
          ),
        ],
      ),
    );
  }
}
