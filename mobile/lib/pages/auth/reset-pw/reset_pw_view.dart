import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/auth/reset-pw/reset_pw_controller.dart';
import 'package:mobile/widgets/auth/input_field.dart';

class ResetPwView extends GetView<ResetPwController> {
  const ResetPwView({super.key});

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
                    'Đặt mật khẩu mới',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4a66f0)
                    ),
                  )
                ],
              ),
      
              Row(
                children: [

                ],
              ),
      
              const SizedBox(height: 20),
      
              Obx(() =>
                InputField(
                  hintText: 'Mật khẩu mới', 
                  placeholder: 'Tạo mật khẩu mới', 
                  obscureText: controller.showPassword.value, 
                  ctrler: controller.passwordController, 
                  borderColor: Colors.grey.shade300, 
                  errorMsg: controller.passwordError.value,
                  onTap: controller.toggleShowPassword,
                ),
              ),
      
              const SizedBox(height: 5),
      
              Obx(() =>
                InputField(
                  hintText: 'Xác nhận mật khẩu', 
                  placeholder: 'Nhập lại mật khẩu', 
                  obscureText: controller.showRePassword.value, 
                  ctrler: controller.rePasswordController, 
                  borderColor: Colors.grey.shade300, 
                  errorMsg: controller.repasswordError.value,
                  onTap: controller.toggleShowRePassword,
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  controller.resetPassword();
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
                        'Đặt lại mật khẩu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
      
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      BoxIcons.bx_left_arrow_alt,
                      size: 24,
                      color: Color(0xff4a66f0),
                    ),
    
                    Text(
                      'Quay lại đăng nhập?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4a66f0)
                      ),
                    )
                  ],
                )
              ),

              const SizedBox(height: 5),
      
              Obx(() => controller.commonError.value.isNotEmpty ? SizedBox(
                height: 20,
                child: Text(
                  controller.commonError.value,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ) : const SizedBox(height: 20)),
      
              const SizedBox(height: 5),

            ],
          ),
        ),
      ),
    );
  }
}