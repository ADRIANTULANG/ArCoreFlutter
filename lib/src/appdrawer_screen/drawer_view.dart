import 'package:arproject/config/textstyles.dart';
import 'package:arproject/src/bottomnavigation_screen/controller/bottomnavigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../faqs_screen/view/faqs_view.dart';
import '../home_screen/widget/home_alertdialogs.dart';
import '../orderhistory_screen/view/orderhistory_view.dart';
import '../terms_and_conditions_screen/view/terms_and_conditions_view.dart';

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
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Get.back();
              Get.find<BottomNavigationController>()
                  .currentSelectedIndex
                  .value = 0;
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_sharp),
            title: const Text('Pending Orders'),
            onTap: () {
              Get.back();
              Get.find<BottomNavigationController>()
                  .currentSelectedIndex
                  .value = 1;
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_2_outlined),
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
            leading: const Icon(Icons.question_mark),
            title: const Text('FAQs'),
            onTap: () {
              Get.to(() => const FAQsView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: const Text('Terms and Conditions'),
            onTap: () {
              Get.to(() => const TermsAndConditionsView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('Contact us'),
            onTap: () {
              Get.back();
              showBottosheets();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () async {
              Get.back();
              HomeScreenAlertDialog.showLogoutConfirmation();
            },
          ),
        ],
      ),
    );
  }

  static showBottosheets() async {
    Get.bottomSheet(Container(
      height: 15.h,
      width: 100.w,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                if (!await launchUrl(
                  Uri.parse("https://www.facebook.com/lywell.pugal.9"),
                  webOnlyWindowName: '_blank',
                )) {
                  throw Exception('Could not launch facebook url');
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.facebook,
                    color: Colors.lightBlue,
                  ),
                  Text(
                    "Facebook",
                    style: Styles.header3,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: "+639934579545",
                );
                await launchUrl(launchUri);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                  Text(
                    "Phone",
                    style: Styles.header3,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'cjmoose03@gmail.com',
                );

                launchUrl(emailLaunchUri);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.red,
                  ),
                  Text(
                    "Email",
                    style: Styles.header3,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
