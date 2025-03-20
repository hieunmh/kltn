import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileSetting extends StatelessWidget {
  final String name;
  const ProfileSetting({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(BoxIcons.bxs_user, size: 16),
              const SizedBox(width: 10),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/profile');
            },
            child: Icon(FontAwesome.chevron_right_solid, size: 16),
          )
        ],
      ),
    );
  }
}