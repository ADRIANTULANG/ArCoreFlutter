import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/textstyles.dart';
import '../controller/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RegistrationController());
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value == true
            ? SizedBox(
                height: 100.h,
                width: 100.w,
                child: Center(
                  child: SpinKitThreeBounce(
                    color: Colors.lightBlue,
                    size: 50.sp,
                  ),
                ),
              )
            : SizedBox(
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
                                  image: AssetImage(
                                      'assets/images/blurlightsnew.jpg'))),
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
                                    image: AssetImage(
                                        'assets/images/modspace.png'))),
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
                              "Create new account",
                              style: Styles.header1,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              height: 7.h,
                              width: 100.w,
                              child: TextField(
                                controller: controller.firstname,
                                decoration: InputDecoration(
                                    fillColor: Colors.lightBlue[50],
                                    filled: true,
                                    contentPadding: EdgeInsets.only(left: 3.w),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: 'First name',
                                    hintStyle:
                                        const TextStyle(fontFamily: 'Bariol')),
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
                                controller: controller.lastname,
                                decoration: InputDecoration(
                                    fillColor: Colors.lightBlue[50],
                                    filled: true,
                                    contentPadding: EdgeInsets.only(left: 3.w),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: 'Last name',
                                    hintStyle:
                                        const TextStyle(fontFamily: 'Bariol')),
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
                                controller: controller.email,
                                decoration: InputDecoration(
                                    fillColor: Colors.lightBlue[50],
                                    filled: true,
                                    contentPadding: EdgeInsets.only(left: 3.w),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: 'Email',
                                    hintStyle:
                                        const TextStyle(fontFamily: 'Bariol')),
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
                                    hintStyle:
                                        const TextStyle(fontFamily: 'Bariol')),
                              ),
                            ),
                            SizedBox(
                              height: .2.h,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: SizedBox(
                                width: 100.w,
                                height: 7.h,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 156, 213, 240)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              side: const BorderSide(
                                                  color: Colors.white)))),
                                  onPressed: () {
                                    if (controller.email.text.isEmpty ||
                                        controller.password.text.isEmpty ||
                                        controller.firstname.text.isEmpty ||
                                        controller.lastname.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Empty field'),
                                      ));
                                    } else if (controller.email.text.isEmail ==
                                        false) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Invalid Email'),
                                      ));
                                    } else {
                                      controller.signUpUser();
                                    }
                                    // controller.sampleEmail();
                                  },
                                  child:
                                      Text("Register", style: Styles.header1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: Styles.mediumTextNormal,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "Sign in here.",
                                    style: Styles.mediumTextBold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
