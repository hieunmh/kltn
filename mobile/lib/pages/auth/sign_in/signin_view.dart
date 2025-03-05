import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/auth/sign_in/signin_controller.dart';
import 'package:mobile/widgets/auth/input_field.dart';
import 'package:icons_plus/icons_plus.dart';


class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0.0,
      ),
      body: Obx(() =>
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Login Account',
                      style: TextStyle(
                        color: Color(0xFF4a66f0),
                        fontSize: 28,
                        fontWeight: FontWeight.w800
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Welcome back!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
        
                const SizedBox(height: 20),
        
                InputField(
                  hintText: 'Email Address', 
                  placeholder: 'Enter email address', 
                  obscureText: false, 
                  ctrler: controller.emailController, 
                  borderColor: Colors.grey.shade300, 
                  errorMsg: controller.emailError.value
                ),
        
                const SizedBox(height: 10),
        
                InputField(
                  hintText: 'Password', 
                  placeholder: 'Enter password', 
                  obscureText: controller.showPassword.value, 
                  ctrler: controller.passwordController, 
                  borderColor: Colors.grey.shade300, 
                  errorMsg: controller.passwordError.value,
                  onTap: controller.toggleShowPassword,
                ),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.goToForgotPw();
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xFF4a66f0),
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ],
                ),
        
                const SizedBox(height: 20),
        
                GestureDetector(
                  onTap: () {
                    controller.signin();
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
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
        
                const SizedBox(height: 5),

                controller.commonError.value.isNotEmpty ? SizedBox(
                  height: 20,
                  child: Text(
                    controller.commonError.value,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ) : const SizedBox(height: 20),

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
                        'Or sign in with',
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
                        // Get.toNamed('/forgot-password');
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
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    ),
        
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        ' Create Account',
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
        ),
      )
    );
  }
}