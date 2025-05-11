import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/theme/app_color.dart';
import 'package:mobile/theme/theme_controller.dart';

class SuggestTheme extends StatelessWidget {
  final ThemeController themeController;
  final bool isLoadingGenerate;
  final Function() onGenerate;
  final Function(String) onSetLevel;
  final TextEditingController subjectController;
  final String error;
  final String theme;
  final Function() onStart;
  
  const SuggestTheme({
    super.key,
    required this.themeController,
    this.isLoadingGenerate = false,
    required this.onGenerate,
    required this.onSetLevel,
    required this.subjectController,
    required this.error,
    required this.theme,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
      height: Get.height * 0.35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeController.isDark.value ? AppColor.bgDarkThemeColor : AppColor.bgLightThemeColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 45,
                    width: 150,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: themeController.isDark.value ? Colors.white.withAlpha(20) : Colors.black.withAlpha(20),
                      ),
                      dropdownColor: themeController.isDark.value ? Colors.black : Colors.white,
                      hint: Text('Chọn trình độ', style: TextStyle(fontSize: 13)),
                      items: [
                        DropdownMenuItem(
                          value: 'Grade 1',
                          child: Text('Lớp 1', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 2',
                          child: Text('Lớp 2', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 3',
                          child: Text('Lớp 3', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 4',
                          child: Text('Lớp 4', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 5',
                          child: Text('Lớp 5', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 6',
                          child: Text('Lớp 6', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 7',
                          child: Text('Lớp 7', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 8',
                          child: Text('Lớp 8', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 9',
                          child: Text('Lớp 9', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 10',
                          child: Text('Lớp 10', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 11',
                          child: Text('Lớp 11', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Grade 12',
                          child: Text('Lớp 12', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'University',
                          child: Text('Đại học', style: TextStyle(fontSize: 13)),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('Khác', style: TextStyle(fontSize: 13)),
                        ),
                      ],
                      onChanged: (String? value) {
                        onSetLevel(value ?? '');
                      },
                    ),
                  ),

                  const SizedBox(width: 10),              

                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: subjectController,
                        cursorColor: themeController.isDark.value ? Colors.white : Colors.black,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          prefixIcon: Icon(
                            Iconsax.book_outline,
                            color: themeController.isDark.value ? Colors.white : Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                              width: 0.5
                            )
                          ),
                          fillColor: themeController.isDark.value ? Colors.white.withAlpha(10) : Colors.white,
                          filled: true,
                          hintText: 'Nội dung muốn học',
                          hintStyle: TextStyle(
                            color: themeController.isDark.value ? Colors.white.withAlpha(100) : Colors.black.withAlpha(100),
                            fontWeight: FontWeight.w600
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                              width: 0.5,
                            )
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ), 
              
              SizedBox(
                height: 20,
                child: Text(
                  error, 
                  style: TextStyle(fontSize: 13, color: Colors.red, fontWeight: FontWeight.w600)
                ),
              ),
            ]
          ),

          SizedBox(
            child: Text(
              theme,
              style: TextStyle(fontSize: 13, color: themeController.isDark.value ? Colors.white : Colors.black),
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (!isLoadingGenerate) {
                          onGenerate();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFF4a66f0),
                            width: 2,
                          ),
                        ),
                        child: isLoadingGenerate 
                          ? Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Color(0xFF4a66f0),
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.lamp_charge_bold, color: Color(0xFF4a66f0)),
                                const SizedBox(width: 5),
                                Text(
                                  'Tạo chủ đề',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF4a66f0),
                                  ),
                                ),
                              ],
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onStart();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: theme.isEmpty ? Colors.grey : Color(0xFF4a66f0),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: theme.isEmpty ? Colors.grey : Color(0xFF4a66f0),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(BoxIcons.bxs_graduation, color: Colors.white),
                            const SizedBox(width: 5),
                            Text(
                              'Bắt đầu học',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
