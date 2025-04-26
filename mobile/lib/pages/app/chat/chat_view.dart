import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/chat/chat_controller.dart';
import 'package:mobile/theme/app_color.dart';
import 'package:mobile/widgets/app/chat/edit_chat.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Get.bottomSheet(
                Container(
                    height: Get.height * 0.30,
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Select model',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 40,
                              width: 150,
                              child: DropdownButtonFormField<String>(
                                value: 'geminiai',
                                decoration: InputDecoration(
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: controller.themeController.isDark.value ? Colors.white.withAlpha(20) : Colors.black.withAlpha(20)
                                ),
                                dropdownColor: controller.themeController.isDark.value ? Colors.black : Colors.white,
                                items: [
                                  DropdownMenuItem(
                                    value: 'geminiai',
                                    child: Text('Gemini AI', style: TextStyle(fontSize: 13)),
                                  ),
                                  DropdownMenuItem(
                                    value: 'openai',
                                    child: Text('Open AI', style: TextStyle(fontSize: 13)),
                                  ),
                                ],
                                onChanged: (String? value) {
                                  controller.model.value = value ?? '';
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
    
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
                            child: Obx(() => Center(
                              child: controller.isLoading.value ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: controller.themeController.isDark.value ? Colors.black : Colors.white,
                                  strokeWidth: 2,
                                ),
                              ) : Text(
                                'Create chat',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: controller.themeController.isDark.value ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            )),
                          ),
                        )           
                      ],
                  ),
                ),
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
      body: Obx(() {
        if (controller.chatList.isEmpty) {
          return Center(
            child: Text(
              'No message found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: controller.chatList.length,
            itemBuilder: (context, index) {
              final chat = controller.chatList[index];
              return Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                  color: controller.themeController.isDark.value ? Colors.white.withAlpha(15) : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.getChatMessage(chat.id, chat.name);
                        },
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          chat.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    PopupMenuButton(
                      color: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                          width: 0.5,
                        ),
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => EditChat(
                                  themeController: controller.themeController,
                                  newNameController: controller.newNameController,
                                  onpress: controller.updateChatName,
                                  chatid: chat.id,
                                ),
                              );
                            },
                            value: 'rename',
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(BoxIcons.bx_pencil),
                                SizedBox(width: 5),
                                Text('Rename'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Get.dialog(
                                CupertinoAlertDialog(
                                  content: Text('Are you sure to delete this conversation?'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.blue.shade600,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.deleteChat(chat.id);
                                        Get.back();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Delete conversation successfully!'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            value: 'delete',
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(BoxIcons.bx_trash, color: Colors.red),
                                SizedBox(width: 5),
                                Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ];
                      },
                      child: Icon(
                        BoxIcons.bx_dots_horizontal_rounded,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}