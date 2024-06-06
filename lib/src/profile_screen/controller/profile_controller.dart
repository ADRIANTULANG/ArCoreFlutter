import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:arproject/services/authentication_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController contactno = TextEditingController();
  TextEditingController address = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? pickedImage;
  RxString imagePath = ''.obs;
  RxString filename = ''.obs;
  Uint8List? uint8list;

  UploadTask? uploadTask;
  RxString imageLink =
      'https://firebasestorage.googleapis.com/v0/b/arecommerce-c4c25.appspot.com/o/profilenew.jpg?alt=media&token=274ab762-6360-44de-b86b-d7e63169e1da&_gl=1*fcmvvp*_ga*MTEwNDMyMTk3LjE2OTgzMzk3OTk.*_ga_CW55HF8NVT*MTY5OTAyMjU4My4xOC4xLjE2OTkwMjM1NDYuMzQuMC4w'
          .obs;

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }

  getUserDetails() async {
    try {
      if (Get.find<AuthenticationService>().hasVerifiedUser.value) {
        FirebaseAuth auth = FirebaseAuth.instance;
        User? user = auth.currentUser;
        var userDetails = await FirebaseFirestore.instance
            .collection('users')
            .where('userid', isEqualTo: user!.uid)
            .limit(1)
            .get();
        if (userDetails.docs.isNotEmpty) {
          firstname.text = userDetails.docs[0]['firstname'];
          lastname.text = userDetails.docs[0]['lastname'];
          address.text = userDetails.docs[0]['address'];
          contactno.text = userDetails.docs[0]['contactno'];
          if (userDetails.docs[0]['imageUrl'] != "") {
            imageLink.value = userDetails.docs[0]['imageUrl'];
          }
        }
      }
    } on Exception catch (_) {
      log("ERROR (getUserDetails): ${_.toString()}");
    }
  }

  getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
      imagePath.value = pickedImage!.path;
      filename.value = pickedImage!.path.split('/').last;
      uint8list = Uint8List.fromList(File(imagePath.value).readAsBytesSync());
    }
  }

  updateProfile() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      var userDetails = await FirebaseFirestore.instance
          .collection('users')
          .where('userid', isEqualTo: user!.uid)
          .limit(1)
          .get();

      if (userDetails.docs.isNotEmpty) {
        if (pickedImage != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child("profileimage/${filename.value}");
          uploadTask = ref.putData(uint8list!);
          final snapshot = await uploadTask!.whenComplete(() {});
          imageLink.value = await snapshot.ref.getDownloadURL();
        }
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userDetails.docs[0].id)
            .update({
          "firstname": firstname.text,
          "lastname": lastname.text,
          "imageUrl": imageLink.value,
          "address": address.text,
          "contactno": contactno.text,
        });
        Get.snackbar("Message", "Profile info updated",
            backgroundColor: Colors.lightBlue[200], colorText: Colors.white);
      }
    } catch (_) {}
  }
}
