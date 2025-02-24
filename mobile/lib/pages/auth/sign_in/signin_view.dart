import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/auth/sign_in/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            
          ],
        ),
      )
    );
  }
}