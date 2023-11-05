import 'dart:io';
import 'dart:typed_data';
import 'package:arproject/src/admin_home_screen/controller/admin_home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminEditProductsController extends GetxController {
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productdescription = TextEditingController();
  TextEditingController woodText = TextEditingController();
  TextEditingController specificationText = TextEditingController();

  RxList<String> woodTypesList = <String>[].obs;
  RxList<String> specificationList = <String>[].obs;
  RxBool isEditing = false.obs;

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

  RxString imageLink = ''.obs;
  RxString modelLink = ''.obs;
  RxString productID = ''.obs;

  @override
  void onInit() async {
    productID.value = await Get.arguments['productID'];
    imageLink.value = await Get.arguments['imageLink'];
    modelLink.value = await Get.arguments['modelLink'];
    productname.text = await Get.arguments['productname'];
    productprice.text = await Get.arguments['productprice'];
    productdescription.text = await Get.arguments['productdescription'];
    woodTypesList.assignAll(await Get.arguments['woodTypesList']);
    specificationList.assignAll(await Get.arguments['specificationList']);

    super.onInit();
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

  updateProducts() async {
    // upload model first
    isEditing(true);
    try {
      if (pickedARfile != null) {
        var modeluint8list =
            Uint8List.fromList(File(pickedARfile!.path).readAsBytesSync());
        final ref =
            FirebaseStorage.instance.ref().child("models/${arFilename.value}");
        var uploadTask = ref.putData(modeluint8list);
        final snapshot = await uploadTask.whenComplete(() {});
        modelLink.value = await snapshot.ref.getDownloadURL();
      }

      // upoad image
      if (pickedImage != null) {
        var imageuint8list =
            Uint8List.fromList(File(imagePath.value).readAsBytesSync());
        final imageref =
            FirebaseStorage.instance.ref().child("files/${filename.value}");
        var uploadTaskimage = imageref.putData(imageuint8list);
        final snapshotimage = await uploadTaskimage.whenComplete(() {});
        imageLink.value = await snapshotimage.ref.getDownloadURL();
      }
      // upload to products
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productID.value)
          .update({
        "arFile": modelLink.value,
        "description": productdescription.text,
        "image": imageLink.value,
        "isNew": true,
        "name": productname.text,
        "price": double.parse(productprice.text.toString()),
        "specifications": specificationList,
        "woodTypes": woodTypesList
      });
      Get.back();
      Get.snackbar("Message", "Product Updated.",
          backgroundColor: Colors.lightBlue[50], colorText: Colors.black);
      Get.find<AdminHomeController>().getProducts();
    } on Exception catch (_) {}
    isEditing(false);
  }
}
