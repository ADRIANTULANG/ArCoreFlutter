import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../model/chat_model.dart';

class ChatController extends GetxController {
  TextEditingController message = TextEditingController();
  ScrollController scrollController = ScrollController();
  final firebase = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>>? userDocumentReference;
  Stream? streamChats;
  StreamSubscription<dynamic>? listener;
  RxString orderID = ''.obs;
  RxList<Chats> chatList = <Chats>[].obs;

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

  sendMessage({required String chat}) async {
    try {
      await FirebaseFirestore.instance.collection('chat').add({
        "customerDetail": userDocumentReference!,
        "datetime": Timestamp.now(),
        "message": chat,
        "orderID": orderID.value.toString(),
        "sender": userDocumentReference!.id,
      });
      message.clear();
      Future.delayed(const Duration(seconds: 1), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    } catch (_) {}
  }

  @override
  void onClose() {
    if (listener != null) {
      listener!.cancel();
    }
    super.onClose();
  }
}
