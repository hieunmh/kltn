import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/models/message.dart';
import 'package:mobile/pages/app/chat/message/msg_controller.dart';
import 'package:mobile/theme/app_color.dart';
import 'package:mobile/widgets/app/chat/message_box.dart';

class MsgView extends GetView<MsgController> {
  const MsgView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = controller.themeController.isDark.value;
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: isDark 
                ? AppColor.bgDarkThemeColor.withAlpha(120) 
                : Colors.white.withAlpha(120),
            title: Row(
              children: [
                Expanded(
                  child: Obx(() => Text(
                    controller.chatName.value,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,  
                    ),
                  )),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // Get.toNamed('/post/create');
                },
                icon: const Icon(BoxIcons.bx_dots_horizontal_rounded),
                iconSize: 24,
              )
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                color: isDark 
                    ? Colors.grey.shade700 
                    : Colors.grey.shade400, 
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
        ),
        backgroundColor: isDark ? AppColor.bgDarkThemeColor : AppColor.bgLightThemeColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Obx(() => controller.messages.isEmpty 
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Center(
                      child: Text(
                        'Loading messages...',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ) 
                : GroupedListView<dynamic, String>(
                    elements: controller.messages,
                    padding: const EdgeInsets.fromLTRB(15, 115, 15, 0),
                    groupBy: (dynamic msg) => msg.createdAt,
                    groupSeparatorBuilder: (String groupValue) => const SizedBox(height: 15),
                    order: GroupedListOrder.DESC,
                    reverse: true,
                    itemBuilder: (context, dynamic element) {
                      return MessageBox(
                        message: element as Message,
                        isDark: isDark,
                      );
                    },
                  )
              ),
            ),

            Obx(() => controller.isAIresponding.value 
              ? Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                      child: const Text(
                        'AI is responding...'
                      ),
                    ),
                  ],
                ) 
              : const SizedBox()
            ),
      
            Container(
              padding: EdgeInsets.zero, 
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark 
                        ? Colors.grey.shade800 
                        : Colors.grey.shade300,
                    width: 1
                  ),
                ), 
              ),
              child: Container(
                height: 90,
                width: double.infinity,
                color: isDark ? AppColor.bgDarkThemeColor : Colors.white,
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                child: Row(
                  children: [
                    const Icon(Iconsax.add_circle_bold),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: controller.msgController,
                        cursorColor: isDark ? Colors.white : Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400
                          ),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        controller.createMessage();
                      },
                      child: const Icon(Iconsax.send_1_bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
