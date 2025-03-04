import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/auth/verify/verify_code_controller.dart';
import 'package:pinput/pinput.dart';

class VerifyCodeView extends GetView<VerifyCodeController> {
  const VerifyCodeView({super.key});

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
                    'Verification',
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
                    'Enter the code to continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              Text(
                'We sent a reset code to',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),
              ),

              Obx(() =>
                Text(
                  controller.email.value,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xff4a66f0)
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Pinput(
                onChanged: (value) {
                  controller.code.value = value;
                },
                defaultPinTheme: PinTheme(
                  width: (Get.width - 40) / 4,
                  height: (Get.width - 40) / 4,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                focusedPinTheme: PinTheme(
                  width: (Get.width - 40) / 4,
                  height: (Get.width - 40) / 4,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff4a66f0), width: 2),
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
              ),

              const SizedBox(height: 5),

              Obx(() =>
                controller.commonError.value.isNotEmpty ? SizedBox(
                  height: 20,
                  child: Text(
                    controller.commonError.value,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ) : const SizedBox(height: 20),
              ),

              const SizedBox(height: 5),
              
              GestureDetector(
                onTap: () {
                  controller.verifyCode();
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
                      ),
                    ) : Text(
                      'Verify',
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Did\'t receive code? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
      
                  GestureDetector(
                    onTap: () {
                      // Get.back();
                    },
                    child: Text(
                      'Send again',
                      style: TextStyle(
                        color: Color(0xFF4a66f0),
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}