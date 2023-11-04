import 'package:arproject/src/admin_bottomnavigation_screen/controller/admin_bottomnavigation_controller.dart';
import 'package:arproject/src/admin_orders_screen/controller/admin_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../admin_home_screen/controller/admin_home_controller.dart';

class AdminBottomNavigationView
    extends GetView<AdminBottomNavigationController> {
  const AdminBottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminBottomNavigationController());
    Get.put(AdminHomeController());
    Get.put(AdminOrderController());
    return Scaffold(
      body:
          Obx(() => controller.screens[controller.currentSelectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
            backgroundColor: Colors.white,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            // showSelectedLabels: true,
            // showUnselectedLabels: false,
            onDestinationSelected: (index) {
              controller.currentSelectedIndex.value = index;
            },
            elevation: 20,
            selectedIndex: controller.currentSelectedIndex.value,
            indicatorColor: Colors.white,
            destinations: <Widget>[
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.home,
                    size: 20.sp,
                    color: Colors.lightBlue[100],
                  ),
                  icon: Icon(
                    Icons.home,
                    size: 20.sp,
                  ),
                  label: "Home"),
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.receipt_long,
                    size: 20.sp,
                    color: Colors.lightBlue[100],
                  ),
                  icon: Icon(
                    Icons.receipt_long,
                    size: 20.sp,
                  ),
                  label: "Orders"),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Colors.white),
              borderRadius: BorderRadius.circular(100)),
          backgroundColor: Colors.lightBlue[100],
          onPressed: () {},
          child: const Icon(
            Icons.add_circle_outline_sharp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
