import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationServices extends GetxController {
  Location location = Location();

  bool? serviceEnabled;
  PermissionStatus? permissionGranted;
  LocationData? locationData;
  LatLng currentLocation = const LatLng(0.0, 0.0);

  getLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled == null) {
      serviceEnabled = await location.requestService();
      if (serviceEnabled == null) {
        return;
      }
    }

    locationData = await location.getLocation();
    currentLocation = LatLng(locationData!.latitude!, locationData!.longitude!);
    log("CURRENT LOCATION::::: ${currentLocation.toString()}");
  }

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }
}
