import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../model/chat_model.dart';

class AdminChatController extends GetxController {
  TextEditingController message = TextEditingController();
  ScrollController scrollController = ScrollController();
  final firebase = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>>? userDocumentReference;
  Stream? streamChats;
  StreamSubscription<dynamic>? listener;
  RxString orderID = ''.obs;
  RxString customerUserID = ''.obs;
  RxString customerDocumentID = ''.obs;
  RxList<Chats> chatList = <Chats>[].obs;

  @override
  void onInit() async {
    orderID.value = await Get.arguments['orderID'];
    customerUserID.value = await Get.arguments['customerUserID'];
    customerDocumentID.value = await Get.arguments['customerDocumentID'];

    await getUserDetails();
    super.onInit();
  }

  getUserDetails() async {
    userDocumentReference =
        firebase.collection('users').doc(customerDocumentID.value);

    listenToChanges(userDocumentReference: userDocumentReference!);
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

  sendMessage({required String chat}) async {
    try {
      await FirebaseFirestore.instance.collection('chat').add({
        "customerDetail": userDocumentReference!,
        "datetime": Timestamp.now(),
        "message": chat,
        "orderID": orderID.value.toString(),
        "sender": "Admin",
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
