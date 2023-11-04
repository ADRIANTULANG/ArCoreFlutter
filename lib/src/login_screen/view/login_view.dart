import 'package:arproject/src/login_screen/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/textstyles.dart';
import '../../registration_screen/view/registration_view.dart';
import '../widget/login_alertdialogs.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 35.h,
                  width: 100.w,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage('assets/images/blurlightsnew.jpg'))),
                ),
                SizedBox(
                  height: 25.h,
                  width: 100.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Image.asset('assets/images/arimage.png'),
                  ),
                ),
                Positioned(
                  top: 19.h,
                  child: Container(
                    height: 8.h,
                    width: 100.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/modspace.png'))),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 30.h,
              child: Container(
                height: 80.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Welcome to Modspace",
                      style: Styles.header1,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      height: 7.h,
                      width: 100.w,
                      child: TextField(
                        controller: controller.email,
                        decoration: InputDecoration(
                            fillColor: Colors.lightBlue[50],
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 3.w),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Email',
                            hintStyle: const TextStyle(fontFamily: 'Bariol')),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      height: 7.h,
                      width: 100.w,
                      child: TextField(
                        controller: controller.password,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.lightBlue[50],
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 3.w),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Password',
                            hintStyle: const TextStyle(fontFamily: 'Bariol')),
                      ),
                    ),
                    SizedBox(
                      height: .2.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          LoginAlertdialog.showDialogForgotPassword(
                              controller: controller);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: Styles.smalltext,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: SizedBox(
                        width: 100.w,
                        height: 7.h,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 156, 213, 240)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: const BorderSide(
                                          color: Colors.white)))),
                          onPressed: () {
                            if (controller.email.text.isEmpty ||
                                controller.password.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Empty field'),
                              ));
                            } else if (controller.email.text.isEmail == false) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Invalid Email'),
                              ));
                            } else {
                              controller.login();
                            }
                            // controller.sampleEmail();
                          },
                          child: Text("LOGIN", style: Styles.header1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont have an account?",
                          style: Styles.mediumTextNormal,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => const RegistrationView());
                          },
                          child: Text(
                            "Create account here.",
                            style: Styles.mediumTextBold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: InkWell(
                        onTap: () async {
                          controller.googleSignin();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 6.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/googles.png"),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: InkWell(
                        onTap: () async {
                          LoginAlertdialog.showDialogAdminLogin(
                              controller: controller);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 6.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.admin_panel_settings_sharp,
                                  color: Colors.pink[50],
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  "Continue as Admin",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
