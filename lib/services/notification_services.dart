import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

class NotificationServices extends GetxService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token;

  @override
  Future<void> onInit() async {
    await checkNotificationPermission();
    super.onInit();
  }

  Future<void> notificationSetup() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.High,
        ),
        NotificationChannel(
          channelKey: 'basic_channel_muted',
          channelName: 'Basic muted notifications ',
          channelDescription: 'Notification channel for muted basic tests',
          importance: NotificationImportance.High,
          playSound: false,
        )
      ],
    );
  }

  Future<void> onForegroundMessage() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        if (message.notification != null) {
          // if (Get.find<StorageService>().storage.read("notificationSound") ==
          //     true) {
          //   AwesomeNotifications().createNotification(
          //     content: NotificationContent(
          //       id: Random().nextInt(9999),
          //       channelKey: 'basic_channel',
          //       title: '${message.notification!.title}',
          //       body: '${message.notification!.body}',
          //       notificationLayout: NotificationLayout.BigText,
          //     ),
          //   );
          // } else {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: Random().nextInt(9999),
              channelKey: 'basic_channel_muted',
              title: '${message.notification!.title}',
              body: '${message.notification!.body}',
              notificationLayout: NotificationLayout.BigText,
            ),
          );

          // }

          // call_unseen_messages();
        }
      },
    );
  }

  Future<void> checkNotificationPermission() async {
    var res = await messaging.requestPermission();
    if (res.authorizationStatus == AuthorizationStatus.authorized) {
      await notificationSetup();
      await onBackgroundMessage();
      await onForegroundMessage();
    }
  }

  // sendNotification({required String userToken}) async {
  //   print(userToken);
  //   var body = jsonEncode({
  //     "to":
  //         "fSw60xJBTW2Bhvksvp8aQ2:APA91bFtS5cuZoDGdlJD2-69OqyTo_8QM62INOk3Ep-B-04820LQkPIowmT416dVnYAxo6d89PILD1zWLjFS0gTeHpRjN_y3nn925uMmpqLjdmf_Ns3tWFnSpOYDTS_5WSQwc0ilfIJL",
  //     "notification": {
  //       "body": "Hi your order is Accepted",
  //       "title": "Food3ip",
  //       "subtitle": "",
  //     }
  //   });
  //   var e2epushnotif =
  //       await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //           headers: {
  //             "Authorization":
  //                 "key=AAAAFXgQldg:APA91bH0blj9KQykFmRZ1Pjub61SPwFyaq-YjvtH1vTvsOeNQ6PTWCYm5S7pOZIuB5zuc7hrFFYsRbuxEB8vF9N5nQoW9fZckjy4bwwltxf4ATPeBDH4L4VlZ1yyVBHF3OKr3yVZ_Ioy",
  //             "Content-Type": "application/json"
  //           },
  //           body: body);
  //   print("e2e notif: ${e2epushnotif.body}");
  // }

  // Future<void> getToken() async {
  //   token = await messaging.getToken();
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(Get.find<StorageServices>().storage.read("id"))
  //       .update({"fcmToken": token});
  //   print('Generated device token: $token');
  // }
}

Future<void> onBackgroundMessage() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    // if (Get.find<StorageService>().storage.read("notificationSound") ==
    //     true) {
    //   AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: Random().nextInt(9999),
    //       channelKey: 'basic_channel',
    //       title: '${message.notification!.title}',
    //       body: '${message.notification!.body}',
    //       notificationLayout: NotificationLayout.BigText,
    //     ),
    //   );
    // } else {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(9999),
        channelKey: 'basic_channel_muted',
        title: '${message.notification!.title}',
        body: '${message.notification!.body}',
        notificationLayout: NotificationLayout.BigText,
      ),
    );
    // if (Get.isRegistered<HomeScreenController>() == true &&
    //     message.data['notif_from'] == "Order Status") {
    //   Get.find<HomeScreenController>().getOrders();
    //   if (Get.isRegistered<OrderDetailScreenController>() == true) {
    //     Get.find<OrderDetailScreenController>().getOrderStatus();
    //   }
    // }
    // if (Get.isRegistered<HomeScreenController>() == true &&
    //     message.data['notif_from'] == "Chat") {
    //   Get.find<HomeScreenController>()
    //       .putMessageIdentifier(order_id: message.data['value']);
    //   if (Get.isRegistered<OrderDetailScreenController>()) {
    //     Get.find<OrderDetailScreenController>().hasMessage.value = true;
    //   }
    // }
    // }

    // call_unseen_messages();
  }
}
