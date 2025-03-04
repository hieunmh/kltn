import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/auth/forgot-pw/forgot_pw_controller.dart';

class ResetPwView extends GetView<ForgotPwController> {
  const ResetPwView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Column(
            children: [
              Text(
                'Reset password view'
              )
            ],
          ),
        ),
      ),
    );
  }
}