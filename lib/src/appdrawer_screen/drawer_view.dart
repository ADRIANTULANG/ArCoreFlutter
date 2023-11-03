import 'package:arproject/src/bottomnavigation_screen/controller/bottomnavigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../orderhistory_screen/view/orderhistory_view.dart';

class AppDrawer {
  static showAppDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
              height: 15.h,
              width: 100.w,
              child: Image.asset("assets/images/logoappbar.png")),
          SizedBox(
            height: 3.h,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Get.back();
              Get.find<BottomNavigationController>()
                  .currentSelectedIndex
                  .value = 0;
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Pending Orders'),
            onTap: () {
              Get.back();
              Get.find<BottomNavigationController>()
                  .currentSelectedIndex
                  .value = 1;
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Get.back();
              Get.find<BottomNavigationController>()
                  .currentSelectedIndex
                  .value = 2;
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Order History'),
            onTap: () {
              Get.to(() => const OrderHistoryView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () async {},
          ),
        ],
      ),
    );
  }
}
