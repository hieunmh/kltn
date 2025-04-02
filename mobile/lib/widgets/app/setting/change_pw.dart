import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/routes/routes.dart';

class ChangePw extends StatelessWidget {
  const ChangePw({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.changepw);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(BoxIcons.bxs_lock, size: 16),
                const SizedBox(width: 10),
                Text(
                  'Change password',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Icon(FontAwesome.chevron_right_solid, size: 16),
          ],
        ),
      ),
    );
  }
}