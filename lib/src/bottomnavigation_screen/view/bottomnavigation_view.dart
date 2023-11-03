import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../home_screen/controller/home_controller.dart';
import '../../order_screen/controller/order_controller.dart';
import '../../profile_screen/controller/profile_controller.dart';
import '../controller/bottomnavigation_controller.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  var controller = Get.put(BottomNavigationController());
  @override
  void initState() {
    Get.put(HomeController());
    Get.put(OrderController());
    Get.put(ProfileController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.person,
                    size: 20.sp,
                    color: Colors.lightBlue[100],
                  ),
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
