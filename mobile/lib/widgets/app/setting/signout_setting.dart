import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SignoutSetting extends StatelessWidget {
  final VoidCallback signout;
  const SignoutSetting({super.key, required this.signout});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context, 
          builder: (context) => CupertinoActionSheet(
            title: Text(
              'Bạn có chắc chắc muốn đăng xuất không?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500
              ),
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  signout();
                  Navigator.pop(context);                       
                },
                child: Text(
                  'Đăng xuất',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                  'Huỷ',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                ),
            ),
          )
        );
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
                Icon(BoxIcons.bxs_log_out, size: 16),
                const SizedBox(width: 10),
                Text(
                  'Đăng xuất',
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