import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/models/message.dart';

class MessageBox extends StatelessWidget {
  final Message message;
  final bool isDark;

  const MessageBox({super.key, required this.message, required this.isDark});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: message.role == 'user' ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: message.role == 'user' ? Get.width * 0.7 : Get.width - 30,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: message.role == 'user' ? 10 : 0, vertical: 10),
              decoration: BoxDecoration(
                color: message.role == 'user' ? isDark ? Colors.white.withAlpha(30) : Colors.black.withAlpha(30) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message.message,
                style: TextStyle(
                  fontSize: 16,
                ),
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
