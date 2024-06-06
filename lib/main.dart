import 'package:arproject/services/authentication_services.dart';
import 'package:arproject/services/getstorage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'services/location_services.dart';
import 'services/notification_services.dart';
import 'src/chat_screen/controller/chat_controller.dart';
import 'src/splash_screen/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAvYyXfpmO5nftCx75AtqTIMwC0sOkoQ2Q',
          appId: '1:1012971008972:android:e04643195dc07f80792369',
          messagingSenderId: '1012971008972',
          storageBucket: "arecommerce-c4c25.appspot.com",
          projectId: 'arecommerce-c4c25'));
  await Permission.location.request();
  await Permission.notification.request();
  await Get.putAsync<AuthenticationService>(
      () async => AuthenticationService());
  await Get.putAsync<LocationServices>(() async => LocationServices());

  // Get.put(AuthenticationService());
  Get.put(NotificationServices());
  Get.put(StorageServices());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    DocumentReference<Map<String, dynamic>>? userDocumentReference;
    var res = await FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: user?.uid)
        .limit(1)
        .get();
    if (res.docs.isNotEmpty) {
      userDocumentReference =
          FirebaseFirestore.instance.collection('users').doc(res.docs[0].id);
    }
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
    } else if (state == AppLifecycleState.paused) {
      if (userDocumentReference != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userDocumentReference.id)
            .update({"isOnline": false});
      }
    } else if (state == AppLifecycleState.resumed) {
      if (userDocumentReference != null) {
        if (Get.isRegistered<ChatController>() == true) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userDocumentReference.id)
              .update({"isOnline": true});
        } else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userDocumentReference.id)
              .update({"isOnline": false});
        }
      }
    } else if (state == AppLifecycleState.inactive) {
      if (userDocumentReference != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userDocumentReference.id)
            .update({"isOnline": false});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Modspace',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const SplashView(),
      );
    });
  }
}
