import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/routes/routes.dart';

class ProfileSetting extends StatelessWidget {
  final String name;
  final String email;
  const ProfileSetting({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.profile);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(BoxIcons.bxs_user, size: 16),
                      const SizedBox(width: 10),
                      Text(
                        'Tên tài khoản',
                        style: TextStyle(
                          fontSize: 16
                        ),
                      )
                    ],
                  ),
            
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(BoxIcons.bxs_envelope, size: 16),
                      const SizedBox(width: 10),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16
                        ),
                      )
                    ],
                  ),
            
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      )
    );
  }
}