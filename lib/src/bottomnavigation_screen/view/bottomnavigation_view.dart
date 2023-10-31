import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/bottomnavigation_controller.dart';

class BottomNavView extends GetView<BottomNavigationController> {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigationController());
    return Scaffold(
      body:
          Obx(() => controller.screens[controller.currentSelectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (index) {
              controller.currentSelectedIndex.value = index;
            },
            elevation: 20,
            currentIndex: controller.currentSelectedIndex.value,
            selectedItemColor: Colors.red[900],
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 20.sp,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.receipt_long,
                    size: 20.sp,
                  ),
                  label: "Orders"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 20.sp,
                  ),
                  label: "Profile"),
            ]),
      ),
    );
  }
}
