import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/theme/theme_controller.dart';

class EditChat extends StatelessWidget {
  final ThemeController themeController;
  final TextEditingController newNameController;
  final Function(String, BuildContext) onpress;
  final String chatid;


  const EditChat({
    super.key,
    required this.themeController,
    required this.newNameController,
    required this.onpress,
    required this.chatid
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      // Thiết lập chiều rộng cho Dialog
      insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Container(
        width: screenWidth * 0.8,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: themeController.isDark.value ? const Color(0xff19191a) : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
              child: Text(
                'Đổi tên',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDark.value ? Colors.white : Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
              child: TextField(
                controller: newNameController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  labelText: 'Tên mới',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text(
                      'Hủy',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Lưu',
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      onpress(chatid, context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}