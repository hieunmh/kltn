import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';

class IdSetting extends StatelessWidget {
  final String id;
  const IdSetting({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(BoxIcons.bxs_id_card, size: 16),
              const SizedBox(width: 10),
              Text(
                '${id.substring(0,20)}...',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: id));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Copied to clipboard'),
                    duration: Duration(seconds: 1),
                  )
                );
            },
            child: Icon(Iconsax.copy_outline, size: 16),
          )
        ],
      ),
    );
  }
}