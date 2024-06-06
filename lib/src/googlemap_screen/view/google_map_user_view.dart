import 'dart:async';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:arproject/services/location_services.dart';
import 'package:arproject/src/placeorder_screen/controller/placeorder_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapUserPage extends StatefulWidget {
  const GoogleMapUserPage({super.key});

  @override
  State<GoogleMapUserPage> createState() => GoogleMapUserPageState();
}

class GoogleMapUserPageState extends State<GoogleMapUserPage> {
  var pagecontroller = Get.find<PlaceOrderController>();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition currentLocation = CameraPosition(
    target: Get.find<LocationServices>().currentLocation,
    zoom: 14.4746,
  );

  RxList<Marker> markers = <Marker>[].obs;
  LatLng selectedLocation = Get.find<LocationServices>().currentLocation;
  LatLng storelocation = Get.find<LocationServices>().currentLocation;
  RxDouble perKMfee = 0.0.obs;

  setMarker({required LatLng latlng}) async {
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId("1"),
      position: latlng,
    ));
  }

  setLocation() async {
    pagecontroller.addressLat.value = selectedLocation.latitude;
    pagecontroller.addressLong.value = selectedLocation.longitude;
    List<Placemark> addresses = await placemarkFromCoordinates(
        selectedLocation.latitude, selectedLocation.longitude);
    var first = addresses.first;
    pagecontroller.address.text =
        ('${first.country} ${first.subAdministrativeArea} ${first.locality} ${first.subLocality}');
    double distanceInMeters = Geolocator.distanceBetween(
        selectedLocation.latitude,
        selectedLocation.longitude,
        storelocation.latitude,
        storelocation.longitude);

    double distanceInKm = distanceInMeters / 1000;
    pagecontroller.shippingFee.value =
        (distanceInKm * perKMfee.value).toStringAsFixed(2);
    log(distanceInKm.toString());
    log(perKMfee.value.toString());
    log(pagecontroller.shippingFee.value.toString());
    Get.back();
  }

  getStoreAddress() async {
    try {
      var res =
          await FirebaseFirestore.instance.collection('storelocation').get();
      var storeLocation = res.docs;
      for (var i = 0; i < storeLocation.length; i++) {
        storelocation =
            LatLng(storeLocation[i]['latitude'], storeLocation[i]['longitude']);
        perKMfee.value = double.parse(storeLocation[i]['perKMfee'].toString());
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
        label: const Text('Set Location'),
        icon: const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
    );
  }
}
