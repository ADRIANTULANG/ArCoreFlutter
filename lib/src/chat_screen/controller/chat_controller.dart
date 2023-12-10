import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/chat_model.dart';
import '../widget/chat_alertdialogs.dart';

class ChatController extends GetxController {
  TextEditingController message = TextEditingController();
  ScrollController scrollController = ScrollController();
  final firebase = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>>? userDocumentReference;
  Stream? streamChats;
  StreamSubscription<dynamic>? listener;
  RxString orderID = ''.obs;
  RxList<Chats> chatList = <Chats>[].obs;
  final ImagePicker picker = ImagePicker();

  @override
  void onInit() async {
    orderID.value = await Get.arguments['orderID'];
    await getUserDetails();
    super.onInit();
  }

  getUserDetails() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var res = await firebase
        .collection('users')
        .where('userid', isEqualTo: user!.uid)
        .limit(1)
        .get();

    if (res.docs.isNotEmpty) {
      userDocumentReference = firebase.collection('users').doc(res.docs[0].id);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDocumentReference!.id)
          .update({"isOnline": true});
      listenToChanges(userDocumentReference: userDocumentReference!);
    }
  }

  listenToChanges(
      {required DocumentReference<Map<String, dynamic>>
          userDocumentReference}) async {
    streamChats = FirebaseFirestore.instance
        .collection("chat")
        .where("customerDetail", isEqualTo: userDocumentReference)
        .where("orderID", isEqualTo: orderID.value)
        .limit(100)
        .orderBy('datetime')
        .snapshots();
    getChat();
  }

  getChat() async {
    try {
      listener = streamChats!.listen((event) async {
        List data = [];
        for (var chats in event.docs) {
          Map mapData = chats.data();
          var customerDetailsDocumentReference =
              mapData['customerDetail'] as DocumentReference;
          var res = await customerDetailsDocumentReference.get();
          mapData['customerDetail'] = res.data();
          mapData['datetime'] = mapData['datetime'].toDate().toString();
          data.add(mapData);
        }
        var encodedData = jsonEncode(data);
        chatList.assignAll(chatsFromJson(encodedData));
        // chatList.sort((a, b) => a.date.compareTo(b.date));
        Future.delayed(const Duration(seconds: 1), () {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      });
    } catch (_) {}
  }

  getImage() async {
    List imagesLinks = [];
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      ChatAlertdialogs.showSendingImages();
      for (var i = 0; i < images.length; i++) {
        String filename = images[i].path.split('/').last;
        final ref = FirebaseStorage.instance.ref().child("files/$filename");
        Uint8List uint8list =
            Uint8List.fromList(File(images[i].path).readAsBytesSync());
        var uploadTask = ref.putData(uint8list);
        final snapshot = await uploadTask.whenComplete(() {});
        String imageLink = await snapshot.ref.getDownloadURL();
        imagesLinks.add(imageLink);
      }
      WriteBatch batch = FirebaseFirestore.instance.batch();
      CollectionReference chatRef =
          FirebaseFirestore.instance.collection('chat');
      for (var link in imagesLinks) {
        DocumentReference docRef = chatRef.doc();
        batch.set(docRef, {
          "customerDetail": userDocumentReference!,
          "datetime": Timestamp.now(),
          "message": link,
          "orderID": orderID.value.toString(),
          "sender": userDocumentReference!.id,
          "isText": false,
        });
      }
      await batch.commit();
      Get.back();
      message.clear();
      Future.delayed(const Duration(seconds: 1), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }
  }

  sendMessage({required String chat}) async {
    try {
      await FirebaseFirestore.instance.collection('chat').add({
        "customerDetail": userDocumentReference!,
        "datetime": Timestamp.now(),
        "message": chat,
        "orderID": orderID.value.toString(),
        "sender": userDocumentReference!.id,
        "isText": true,
      });
      message.clear();
      Future.delayed(const Duration(seconds: 1), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    } catch (_) {}
  }

  @override
  void onClose() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDocumentReference!.id)
          .update({"isOnline": false});
    } on Exception catch (_) {}
    if (listener != null) {
      listener!.cancel();
    }
    super.onClose();
  }
}
