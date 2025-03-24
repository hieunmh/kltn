import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/chat/chat_controller.dart';
import 'package:mobile/theme/app_color.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor.withAlpha(120) : Colors.white.withAlpha(120),
          title: Row(
            children: [
              Text(
                'Chats',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,  
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Get.toNamed(AppRoutes.message);
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context, 
                  builder: (context) {
                    return Container(
                      height: Get.height * 0.85,
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      decoration: BoxDecoration(
                        color: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : AppColor.bgLightThemeColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'New chat',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: controller.themeController.isDark.value ? Colors.white : Colors.black
                                ),
                              ),
                              Icon(Iconsax.code_1_bold, size: 24),
                            ],
                          ),
      
                          SizedBox(
                            height: Get.height * 0.2,
                            child: Center(
                              child: Text(
                                'create chat with AI',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: controller.themeController.isDark.value ? Colors.white : Colors.black
                                ),
                              ),
                            ),
                          ),
      
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            decoration: BoxDecoration(
                              color: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : Colors.white,
                              border: Border.all(
                                color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                                width: 0.5
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Iconsax.add_circle_bold),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: controller.msgController,
                                    cursorColor: controller.themeController.isDark.value ? Colors.white : Colors.black,
                                    decoration: InputDecoration(
                                      hintText: 'Type a message',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade400
                                      ),
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    controller.createChat();
                                  },
                                  child: Icon(Iconsax.send_1_bold),
                                )
                              ],
                            ),
                          ), 
      
                          SizedBox(height: 20),
      
                          GestureDetector(
                            onTap: () {
                              controller.createChat();
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              decoration: BoxDecoration(
                                color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Create Chat',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: controller.themeController.isDark.value ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            ),
                          )           
                        ],
                      ),
                    );
                  }
                );
              },
              icon: Icon(BoxIcons.bx_message_add),
              iconSize: 24,
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Container(
              color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400, 
              height: 0.5
            ),
          ),
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.transparent
              ),
            ),
          ),
        ),
        body: controller.chatList.isEmpty ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'No message found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ) : Container(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: controller.chatList.length,
            itemBuilder: (context, index) {
              final chat = controller.chatList[index];
              return Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                decoration: BoxDecoration(
                  color: controller.themeController.isDark.value ? Colors.white.withAlpha(15) : Colors.grey.shade200,
                ),
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    controller.getChatMessage(chat.id, chat.name);
                  },
                  child: Center(
                    child: Text(
                      chat.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}