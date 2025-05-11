import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/setting/change_pw/pw_controller.dart';
import 'package:mobile/widgets/app/setting/input_field.dart';

class PwView extends GetView<PwController> {
  const PwView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Tạo mật khẩu mới',
                    style: TextStyle(
                      color: Color(0xFF4a66f0),
                      fontSize: 28,
                      fontWeight: FontWeight.w800
                    ),
                  )
                ],
              ),
      
              const SizedBox(height: 20),
      
              Obx(() =>
                InputField(
                  hintText: 'Mật khẩu cũ', 
                  placeholder: 'Nhập mật khẩu cũ', 
                  obscureText: !controller.showOldPw.value, 
                  ctrler: controller.oldPw, 
                  borderColor: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade300, 
                  errorMsg: controller.oldPwError.value,
                  onTap: () => controller.showOldPw.value = !controller.showOldPw.value,
                ),
              ),
      
              const SizedBox(height: 5),
      
              Obx(() =>
                InputField(
                  hintText: 'Mật khẩu mới', 
                  placeholder: 'Nhập mật khẩu mới', 
                  obscureText: !controller.showNewPw.value, 
                  ctrler: controller.newPw, 
                  borderColor: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade300, 
                  errorMsg: controller.newPwError.value,
                  onTap: () => controller.showNewPw.value = !controller.showNewPw.value,
                ),
              ),
      
              const SizedBox(height: 5),
      
              Obx(() =>
                InputField(
                  hintText: 'Xác nhận mật khẩu mới', 
                  placeholder: 'Nhập lại mật khẩu mới', 
                  obscureText: !controller.showReNewPw.value, 
                  ctrler: controller.reNewPw, 
                  borderColor: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade300, 
                  errorMsg: controller.reNewPwError.value,
                  onTap: () => controller.showReNewPw.value = !controller.showReNewPw.value,
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  controller.changePassword();
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF4a66f0)
                  ),
                  child: Center(
                    child: Obx(() => controller.isLoading.value ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,                      
                      ),
                    ) : Text(
                      'Thay đổi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
                  ),
                ),
              ),
              
              const SizedBox(height: 5),

              Obx(() => controller.commonError.value.isNotEmpty ? SizedBox(
                height: 20,
                child: Text(
                  controller.commonError.value,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ) : const SizedBox(height: 20))
            ],
          ),
        ),
      ),
    );
  }
}