import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/app_controller.dart';

class AppView extends GetView<AppController> {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() =>
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Center(
            child: Column(
              children: [
                Text(
                  controller.userid.value
                ),
                Text(
                  controller.email.value
                ),
                Text(
                  controller.name.value
                ),
          
                GestureDetector(
                    onTap: () {
                      controller.signout();
                    },
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF4a66f0)
                      ),
                      child: Center(
                        child: Text(
                          'Sign out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      )
    );
  }
}