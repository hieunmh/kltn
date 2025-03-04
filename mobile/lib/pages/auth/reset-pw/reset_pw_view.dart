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
      body: Obx(() =>
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Set New Password',
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
                    Text(
                      'Create a unique password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
        
                const SizedBox(height: 20),
        
                InputField(
                  hintText: 'New Password', 
                  placeholder: 'Create new password', 
                  obscureText: controller.showPassword.value, 
                  ctrler: controller.passwordController, 
                  borderColor: Colors.grey.shade300, 
                  errorMsg: controller.passwordError.value,
                  onTap: controller.toggleShowPassword,
                ),
        
                const SizedBox(height: 5),
        
                InputField(
                  hintText: 'Confirm Password', 
                  placeholder: 'Re-enter password', 
                  obscureText: controller.showRePassword.value, 
                  ctrler: controller.rePasswordController, 
                  borderColor: Colors.grey.shade300, 
                  errorMsg: controller.passwordError.value,
                  onTap: controller.toggleShowRePassword,
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF4a66f0)
                    ),
                    child: Center(
                      child: controller.isLoading.value ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                          
                          // value: 0.1,
                        ),
                      ) : Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
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
                        'Back to sign in?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4a66f0)
                        ),
                      )
                    ],
                  )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}