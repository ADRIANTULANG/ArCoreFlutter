import 'package:arproject/src/admin_home_screen/view/admin_home_view.dart';
import 'package:arproject/src/admin_orders_screen/view/admin_orders_view.dart';
import 'package:get/get.dart';

class AdminBottomNavigationController extends GetxController {
  RxInt currentSelectedIndex = 0.obs;

  List screens = [
    const AdminHomeView(),
    const AdminOrderView(),
  ];
}
