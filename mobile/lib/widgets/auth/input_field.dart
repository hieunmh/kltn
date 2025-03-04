import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class InputField extends StatelessWidget {

  const InputField({
    super.key, 
    required this.hintText, 
    required this.placeholder, 
    required this.obscureText, 
    required this.ctrler, 
    required this.borderColor,
    required this.errorMsg,
    this.onTap
  });

  final String hintText;
  final String placeholder;
  final bool obscureText;
  final TextEditingController ctrler;
  final Color borderColor;
  final String errorMsg;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              hintText,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            )
          ],
        ),

        const SizedBox(height: 5),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 2) 
          ),
          child: Padding (
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: ctrler,
                    style: const TextStyle(
                      color: Colors.black
                    ),
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: placeholder,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      )
                    ),
                  ),
                ),

                hintText.toLowerCase().contains('password') ? GestureDetector(
                  onTap: onTap as void Function()?,
                  child: Icon(
                    obscureText ? FontAwesome.eye_slash_solid : FontAwesome.eye_solid,
                    color: Colors.grey,
                    size: 20,
                  ),
                ) : const SizedBox(width: 0)
              ],
            ),
          ),
        ),

        const SizedBox(height: 2),

        errorMsg.isNotEmpty ? SizedBox(
          height: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                errorMsg,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 12
                ),
              )
            ],
          ),
        ) : const SizedBox(height: 16),
      ],
    );
  }
}