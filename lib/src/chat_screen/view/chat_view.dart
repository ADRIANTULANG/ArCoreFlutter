import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/chat_controller.dart';
import 'package:intl/intl.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logoappbar.png'),
      ),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.chatList.length,
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 14,
                              right: 14,
                              top: 10,
                            ),
                            child: controller.chatList[index].isText == true
                                ? Align(
                                    alignment:
                                        (controller.chatList[index].sender ==
                                                "Admin"
                                            ? Alignment.topLeft
                                            : Alignment.topRight),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: (controller
                                                    .chatList[index].sender ==
                                                "Admin"
                                            ? Colors.grey.shade200
                                            : Colors.orange[200]),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        controller.chatList[index].message,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  )
                                : Align(
                                    alignment:
                                        (controller.chatList[index].sender ==
                                                "Admin"
                                            ? Alignment.topLeft
                                            : Alignment.topRight),
                                    child: Container(
                                      height: 30.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(controller
                                                  .chatList[index].message))),
                                      padding: const EdgeInsets.all(16),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 7.w,
                              right: 7.w,
                            ),
                            child: Align(
                                alignment: (controller.chatList[index].sender ==
                                        "Admin"
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Text(
                                  "${DateFormat('yMMMd').format(controller.chatList[index].datetime)} ${DateFormat('jm').format(controller.chatList[index].datetime)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 9.sp),
                                )),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 10.h,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    spreadRadius: 3,
                    offset: Offset(1, 2))
              ]),
              padding: EdgeInsets.only(bottom: 2.h, left: 3.w, right: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 6.h,
                    width: 70.w,
                    child: TextField(
                      controller: controller.message,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 3.w),
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Type something..'),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        controller.getImage();
                      },
                      child: const Icon(Icons.attachment)),
                  InkWell(
                      onTap: () {
                        controller.sendMessage(chat: controller.message.text);
                      },
                      child: const Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
