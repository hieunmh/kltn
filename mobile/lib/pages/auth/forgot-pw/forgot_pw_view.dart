import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/auth/forgot-pw/forgot_pw_controller.dart';
import 'package:mobile/widgets/auth/input_field.dart';
import 'package:icons_plus/icons_plus.dart';


class ForgotPwView extends GetView<ForgotPwController> {
  const ForgotPwView({super.key});

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
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4a66f0)
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Text(
                    'No worries, we got you',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
      
              const SizedBox( height: 20),
      
              Obx(() =>
                InputField(
                  hintText: 'Email', 
                  placeholder: 'Enter email address', 
                  obscureText: false, 
                  ctrler: controller.emailController, 
                  borderColor: Colors.grey.shade300, 
                  errorMsg: controller.commonError.value
                ),
              ),
      
              const SizedBox(height: 15),
      
              GestureDetector(
                  onTap: () {
                    controller.forgotPassword();
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF4a66f0)
                    ),
                    child: Center(
                      child: Obx(() =>  controller.isLoading.value ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ) : Text(
                        'Send Code',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ))
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
                      ),
      
                      Text(
                        'Back to sign in?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  )
                ),
      
                const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}