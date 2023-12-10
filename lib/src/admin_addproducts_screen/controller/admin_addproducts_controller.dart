import 'dart:io';
import 'dart:typed_data';
import 'package:arproject/src/admin_bottomnavigation_screen/controller/admin_bottomnavigation_controller.dart';
import 'package:arproject/src/admin_home_screen/controller/admin_home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddProductsController extends GetxController {
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productdescription = TextEditingController();
  TextEditingController woodText = TextEditingController();
  TextEditingController colorText = TextEditingController();
  TextEditingController specificationText = TextEditingController();
  TextEditingController stocks = TextEditingController();

  RxList<String> woodTypesList = <String>[].obs;
  RxList<String> colorTypesList = <String>[].obs;
  RxList<String> specificationList = <String>[].obs;

  RxBool isUploading = false.obs;

  final ImagePicker picker = ImagePicker();
  File? pickedImage;
  File? pickedARfile;
  RxString aRPath = ''.obs;
  RxString arString = 'Upload 3D Model'.obs;
  RxString imagePath = ''.obs;
  RxString filename = ''.obs;
  RxString arFilename = ''.obs;
  Uint8List? uint8list;
  UploadTask? uploadTask;

  getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
      imagePath.value = pickedImage!.path;
      filename.value = pickedImage!.path.split('/').last;
      uint8list = Uint8List.fromList(File(imagePath.value).readAsBytesSync());
    }
  }

  getArFile() async {
    // List<String> allowedExtensions = ['glb'];
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = File(result.files.single.path!).path.split('/').last;
      if (fileName.split('.')[1] == 'glb') {
        pickedARfile = file;
        arString.value = '3D Model Selected';
        arFilename.value = fileName;
      } else {
        Get.snackbar("Message",
            "Invalid file. Please select a 3D Model file or a glb file.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      // User canceled the picker
    }
  }

  addProduct() async {
    // upload model first
    isUploading(true);
    try {
      var modeluint8list =
          Uint8List.fromList(File(pickedARfile!.path).readAsBytesSync());
      final ref =
          FirebaseStorage.instance.ref().child("models/${arFilename.value}");
      var uploadTask = ref.putData(modeluint8list);
      final snapshot = await uploadTask.whenComplete(() {});
      var modelLink = await snapshot.ref.getDownloadURL();
      // upoad image
      var imageuint8list =
          Uint8List.fromList(File(imagePath.value).readAsBytesSync());
      final imageref =
          FirebaseStorage.instance.ref().child("files/${filename.value}");
      var uploadTaskimage = imageref.putData(imageuint8list);
      final snapshotimage = await uploadTaskimage.whenComplete(() {});
      var imageLink = await snapshotimage.ref.getDownloadURL();
      // upload to products
      await FirebaseFirestore.instance.collection('products').add({
        "arFile": modelLink,
        "description": productdescription.text,
        "image": imageLink,
        "isNew": true,
        "name": productname.text,
        "price": double.parse(productprice.text.toString()),
        "specifications": specificationList,
        "woodTypes": woodTypesList,
        "stocks": stocks.text,
        "colors": colorTypesList
      });
      Get.back();
      Get.snackbar("Message", "Product added.",
          backgroundColor: Colors.lightBlue[50], colorText: Colors.black);
      Get.find<AdminHomeController>().getProducts();
      Get.find<AdminBottomNavigationController>().currentSelectedIndex.value =
          0;
    } on Exception catch (_) {}
    isUploading(false);
  }
}
