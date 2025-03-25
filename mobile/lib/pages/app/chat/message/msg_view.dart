import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/chat/message/msg_controller.dart';
import 'package:mobile/theme/app_color.dart';
import 'package:mobile/widgets/app/chat/message_box.dart';

class MsgView extends GetView<MsgController> {
  const MsgView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor.withAlpha(120) : Colors.white.withAlpha(120),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  controller.chatName.value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,  
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Get.toNamed('/post/create');
              },
              icon: Icon(BoxIcons.bx_dots_horizontal_rounded),
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
        backgroundColor: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : AppColor.bgLightThemeColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: controller.messages.isEmpty ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Center(
                  child: Text(
                    'Loading messages...',
                    style: TextStyle(
                      color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ) : GroupedListView(
                // ignore: invalid_use_of_protected_member
                elements: controller.messages.value, 
                padding: const EdgeInsets.fromLTRB(15, 115, 15, 0),
                groupBy: (msg) => msg.createdAt,
                groupSeparatorBuilder: (msg) => SizedBox(height: 15),
                order: GroupedListOrder.DESC,
                reverse: true,
                itemBuilder: (context, element) {
                  return MessageBox(
                    message: element,
                    isDark: controller.themeController.isDark.value,
                  );
                },
              )
            ),

            controller.isAIresponding.value ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  height: 30,
                  child: Text(
                    'AI is responding...'
                  ),
                ),
              ],
            ) : SizedBox(),
      
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0), 
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: controller.themeController.isDark.value ? Colors.grey.shade800 : Colors.grey.shade300,
                    width: 1
                  ),
                ), 
              ),
              child: Container(
                height: 90,
                width: double.infinity,
                color: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : Colors.white,
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
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
                        controller.createMessage();
                      },
                      child: Icon(Iconsax.send_1_bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
