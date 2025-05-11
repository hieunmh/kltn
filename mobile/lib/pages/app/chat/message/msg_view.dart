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
                GestureDetector(
                  onTap: () {
                    print(controller.model.value);
                  },
                  child: Text(
                    'Chọn model',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: DropdownButtonFormField<String>(
                    value: controller.model.value,
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

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade400, 
                height: 0.5
              ),
            ),
          ),
        ),
        backgroundColor: isDark ? AppColor.bgDarkThemeColor : Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(() => controller.messages.isEmpty 
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                          strokeWidth: 3,
                        ),
                      ),
                    ) 
                  : Container(
                      color: isDark ? AppColor.bgDarkThemeColor : AppColor.bgLightThemeColor,
                      child: GroupedListView<dynamic, String>(
                        elements: controller.messages,
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
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
                      ),
                    )
                ),
              ),
          
              Obx(() => controller.isAIresponding.value 
                ? Row(
                    children: [
                      Container(
                        width: Get.width,
                        color: isDark ? AppColor.bgDarkThemeColor : AppColor.bgLightThemeColor,
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: const Text(
                          'AI is responding...'
                        ),
                      ),
                    ],
                  ) 
                : const SizedBox()
              ),

              Obx(() => controller.image.value != null ? 
                Container(
                  width: Get.width,
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.file(
                            controller.image.value!,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 40,
                          ),
                          
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                controller.image.value = null;
                              },
                              child: Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(100),
                                ),
                                child: const Icon(
                                  Iconsax.trash_bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          )
                        ],
                        
                      )
                    ],
                  ),
                ): const SizedBox()
              ),
                
              Container(
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
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: isDark ? AppColor.bgDarkThemeColor : Colors.white,
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: const Icon(Iconsax.add_circle_bold),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: controller.msgController,
                              cursorColor: isDark ? Colors.white : Colors.black,
                              decoration: InputDecoration(
                                hintText: 'Nhập tin nhắn',
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
                  ],
                )
              ),
            ],
          ),
        ),
      );
    });
  }
}
