import 'package:arproject/src/home_screen/controller/home_controller.dart';
import 'package:arproject/src/home_screen/view/home_view.dart';
import 'package:arproject/src/order_screen/controller/order_controller.dart';
import 'package:arproject/src/order_screen/view/order_view.dart';
import 'package:arproject/src/profile_screen/controller/profile_controller.dart';
import 'package:arproject/src/profile_screen/view/profile_view.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  @override
  void onInit() {
    Get.put(OrderController());
    Get.put(HomeController());
    Get.put(ProfileController());
    super.onInit();
  }

  RxInt currentSelectedIndex = 0.obs;

  List screens = [
    const HomeView(),
    const OrderView(),
    const ProfileView(),
  ];
}
