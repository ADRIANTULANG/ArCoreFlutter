import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  RxBool isLoading = false.obs;

  signUpUser() async {
    try {
      isLoading(true);
      List<String> signInMethods =
          await auth.fetchSignInMethodsForEmail(email.text);
      if (signInMethods.isNotEmpty) {
        Get.snackbar("Message", "Email already exist",
            backgroundColor: Colors.lightBlue, colorText: Colors.white);
      } else {
        await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        var user = auth.currentUser!;
        await user.sendEmailVerification();
        await saveUser(userid: user.uid);
        await FirebaseAuth.instance.signOut();
        Get.back();
        Get.snackbar("Message",
            "Account created. We have sent an email to verify your account.",
            backgroundColor: Colors.lightBlue, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar(
          "Message", "Something went wrong please try again later. $e");
    }
    isLoading(false);
  }

  saveUser({required String userid}) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        "userid": userid,
        "email": email.text,
        "isVerified": false,
        "provider": "email",
        "imageUrl": "",
        "firstname": firstname.text,
        "lastname": lastname.text,
        "contactno": "",
        "fcmToken": "",
        "address": "",
        "isOnline": false
      });
    } catch (e) {
      Get.snackbar(
          "Message", "Something went wrong please try again later. $e");
    }
  }
}
