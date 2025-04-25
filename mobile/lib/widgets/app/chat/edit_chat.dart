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
    return AlertDialog(
      backgroundColor: themeController.isDark.value ? Color(0xff19191a) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'Rename',
        style: TextStyle(
          
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: Text(
            'Save',
            style: TextStyle(
              color: Colors.blue.shade600,
              fontWeight: FontWeight.w500
            ),
          ),
          onPressed: () {
            onpress(chatid, context);
          },
        ),
      ],
      content: Container(
        child: TextField(
          onChanged: (value) {
            
          },
          controller: newNameController,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            labelText: 'New name',
            labelStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          
        ),
      ),
    );
  }
}