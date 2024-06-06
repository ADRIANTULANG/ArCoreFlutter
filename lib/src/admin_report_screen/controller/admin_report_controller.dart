import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../model/adminorders_model.dart';
import '../../../model/chart_data_model.dart';

class AdminReportController extends GetxController {
  RxList<ChartData> dataChart = <ChartData>[].obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingEdit = false.obs;

  RxList<AdminOrder> ordersList = <AdminOrder>[].obs;
  RxDouble totalIncome = 0.0.obs;
  RxString selectedDateRange = ''.obs;
  RxString chartType = "Column".obs;
  RxDouble perKMfee = 0.0.obs;
  RxString addressName = "".obs;
  RxString feeDocID = ''.obs;

  getOrders({required DateTime from, required DateTime to}) async {
    var res = await FirebaseFirestore.instance
        .collection('orders')
        .where('dateTime', isGreaterThanOrEqualTo: from)
        .where('dateTime', isLessThanOrEqualTo: to)
        .get();
    var orders = res.docs;
    List orderdata = [];
    for (var i = 0; i < orders.length; i++) {
      Map mapData = orders[i].data();
      mapData['id'] = orders[i].id;
      mapData['dateTime'] = mapData['dateTime'].toDate().toString();
      var customerDetailsDocumentReference =
          mapData['orderedBy'] as DocumentReference;
      var customer = await customerDetailsDocumentReference.get();
      mapData.remove('orderedBy');
      mapData['customerDetails'] = customer.data();
      mapData['customerDetails']['documentID'] = customer.id;
      orderdata.add(mapData);
    }
    var encodedData = jsonEncode(orderdata);
    ordersList.assignAll(adminOrderFromJson(encodedData));
    double cancelledCount = 0;
    double pendingCount = 0;
    double acceptedCount = 0;
    double completeCount = 0;
    double income = 0;
    dataChart.clear();
    for (var i = 0; i < ordersList.length; i++) {
      if (ordersList[i].status == "Pending") {
        pendingCount = pendingCount + 1;
      } else if (ordersList[i].status == "Accepted") {
        acceptedCount = acceptedCount + 1;
      } else if (ordersList[i].status == "Cancelled") {
        cancelledCount = cancelledCount + 1;
      } else if (ordersList[i].status == "Completed") {
        completeCount = completeCount + 1;
        income = income + ordersList[i].totalPrice;
      }
      dataChart.add(ChartData("Pending", pendingCount));
      dataChart.add(ChartData("Accepted", acceptedCount));
      dataChart.add(ChartData("Completed", completeCount));
      dataChart.add(ChartData("Cancelled", cancelledCount));
    }
    totalIncome.value = income;
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value.startDate != null && args.value.endDate != null) {
      DateTime from = DateTime.parse(args.value.startDate.toString());
      DateTime to = DateTime.parse(args.value.endDate.toString());
      selectedDateRange.value =
          "${DateFormat.yMMMMd().format(from)} to ${DateFormat.yMMMMd().format(to)}";
      Get.back();
      getOrders(from: from, to: to);
    }
  }

  getShippingFee() async {
    try {
      var res =
          await FirebaseFirestore.instance.collection('storelocation').get();
      var storeLocation = res.docs;
      for (var i = 0; i < storeLocation.length; i++) {
        perKMfee.value = double.parse(storeLocation[i]['perKMfee'].toString());
        addressName.value = storeLocation[i]['addressname'];
        feeDocID.value = storeLocation[i].id;
      }
    } catch (_) {
      log("ERROR (getShippingFee): ${_.toString()}}");
    }
  }

  editShippingFee({required String fee}) async {
    try {
      isLoadingEdit(true);
      String newfee = double.parse(fee).toStringAsFixed(2);
      await FirebaseFirestore.instance
          .collection('storelocation')
          .doc(feeDocID.value)
          .update({"perKMfee": double.parse(newfee)});
      getShippingFee();
      Get.back();
      isLoadingEdit(false);
    } catch (e) {
      log("ERROR (editShippingFee): ${e.toString()}}");
    }
  }

  @override
  void onInit() async {
    isLoading(true);
    DateTime to = DateTime.now();
    DateTime from = DateTime.now().subtract(const Duration(days: 30));
    selectedDateRange.value =
        "${DateFormat.yMMMMd().format(from)} to ${DateFormat.yMMMMd().format(to)}";
    await getOrders(from: from, to: to);
    await getShippingFee();
    isLoading(false);

    super.onInit();
  }
}
