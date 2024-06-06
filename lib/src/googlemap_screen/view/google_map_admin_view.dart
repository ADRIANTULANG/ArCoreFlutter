import 'dart:async';
import 'dart:developer';
import 'package:arproject/src/admin_report_screen/controller/admin_report_controller.dart';
import 'package:arproject/services/location_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapAdminPage extends StatefulWidget {
  const GoogleMapAdminPage({super.key});

  @override
  State<GoogleMapAdminPage> createState() => GoogleMapAdminPageState();
}

class GoogleMapAdminPageState extends State<GoogleMapAdminPage> {
  var pagecontroller = Get.find<AdminReportController>();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition currentLocation = CameraPosition(
    target: Get.find<LocationServices>().currentLocation,
    zoom: 14.4746,
  );

  RxList<Marker> markers = <Marker>[].obs;
  LatLng selectedLocation = Get.find<LocationServices>().currentLocation;
  RxString storeDocID = ''.obs;

  setMarker({required LatLng latlng}) async {
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId("1"),
      position: latlng,
    ));
  }

  setLocation() async {
    List<Placemark> addresses = await placemarkFromCoordinates(
        selectedLocation.latitude, selectedLocation.longitude);
    var first = addresses.first;
    pagecontroller.addressName.value =
        ('${first.country} ${first.subAdministrativeArea} ${first.locality} ${first.subLocality}');
    await FirebaseFirestore.instance
        .collection('storelocation')
        .doc(storeDocID.value)
        .update({
      "latitude": selectedLocation.latitude,
      "longitude": selectedLocation.longitude,
      "addressname": pagecontroller.addressName.value,
    });
    Get.back();
  }

  getStoreAddress() async {
    try {
      var res =
          await FirebaseFirestore.instance.collection('storelocation').get();
      var storeLocation = res.docs;
      for (var i = 0; i < storeLocation.length; i++) {
        storeDocID.value = storeLocation[i].id;
      }
    } catch (_) {
      log("ERROR (getStoreAddress): ${_.toString()}}");
    }
  }

  @override
  void initState() {
    setMarker(latlng: Get.find<LocationServices>().currentLocation);
    getStoreAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: currentLocation,
          markers: markers.toSet(),
          onTap: (latlng) {
            selectedLocation = latlng;
            setMarker(latlng: selectedLocation);
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightBlue[100],
        onPressed: () {
          setLocation();
        },
        label: const Text('Set Store Location'),
        icon: const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
    );
  }
}
