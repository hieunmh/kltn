import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ThemeSetting extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) setDarkTheme;
  const ThemeSetting({super.key, required this.isDarkMode, required this.setDarkTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(isDarkMode ? BoxIcons.bxs_moon : BoxIcons.bxs_sun, size: 16),
              const SizedBox(width: 10),
              Text(
                'Theme',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          GestureDetector(
            child: Row(
              children: [
                Text(
                  isDarkMode ? 'Dark' : 'Light',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(width: 5),

                Icon(FontAwesome.chevron_down_solid, size: 14)
              ],
            ),
            onTap: () {
              showCupertinoModalPopup(
                context: context, 
                builder: (context) => CupertinoActionSheet(
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        setDarkTheme(false);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Light',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        setDarkTheme(true);
                        Navigator.pop(context);                       
                      },
                      child: Text(
                        'Dark',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                  ),
                )
              );
            }
          )
        ],
      ),
    );
  }
}