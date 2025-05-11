import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/auth/sign_up/signup_controller.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/widgets/auth/input_field.dart';


class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 50),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Tạo tài khoản',
                    style: TextStyle(
                      color: Color(0xFF4a66f0),
                      fontSize: 28,
                      fontWeight: FontWeight.w800
                    ),
                  )
                ],
              ),
      
              const SizedBox(height: 20),
      
              Obx(() => InputField(
                hintText: 'Email', 
                placeholder: 'Nhập email', 
                obscureText: false, 
                ctrler: controller.emailController, 
                borderColor: Colors.grey.shade300, 
                errorMsg: controller.emailError.value
              )),
      
              const SizedBox(height: 5),
      
              Obx(() => InputField(
                hintText: 'Mật khẩu', 
                placeholder: 'Nhập mật khẩu', 
                obscureText: controller.showPassword.value, 
                ctrler: controller.passwordController, 
                borderColor: Colors.grey.shade300, 
                errorMsg: controller.passwordError.value,
                onTap: controller.toggleShowPassword,
              )),
      
              const SizedBox(height: 5),

              Obx(() => InputField(
                hintText: 'Xác nhận mật khẩu', 
                placeholder: 'Nhập lại mật khẩu', 
                obscureText: controller.showRePassword.value, 
                ctrler: controller.rePasswordController, 
                borderColor: Colors.grey.shade300, 
                errorMsg: controller.repasswordError.value,
                onTap: controller.toggleShowRePassword,
              )),

              const SizedBox(height: 20),
      
              GestureDetector(
                onTap: () {
                  controller.signup();
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
                      'Tạo tài khoản',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
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
              ) : const SizedBox(height: 20)),

              const SizedBox(height: 5),
      
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Hoặc tiếp tục với',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                        fontSize: 12
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
      
              const SizedBox(height: 20),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFE5E8FC).withAlpha(120)
                      ),
                      child: Center(
                        child: Brand(
                          Brands.google,  
                          size: 50,
                        )
                      ),
                    ),
                  ),
                ],
              ),
      
              const SizedBox(height: 20),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Đã có tài khoản? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
      
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.signin);
                    },
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Color(0xFF4a66f0),
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}