import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/routes/routes.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Color(0xFF4a66f0),
                        fontSize: 30,
                        fontWeight: FontWeight.w800
                      ),
                    )
                  ],
                ),

                Row(
                  children: [
                    Text(
                      'Login or sign up to continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
              ],
            ),

            Center(
              child: Column(
                children: [
                  Text(
                    'ABF',
                    style: TextStyle(
                      color: Color(0xFF4a66f0),
                      fontSize: 30,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  Text(
                    'E learning platform',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.signup);
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF4a66f0)
                      ),
                      child: Center(
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.signin);
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xFF4a66f0),
                          width: 3
                        )
                      ),
                      child: Center(
                        child: Text(
                          'Already have an account',
                          style: TextStyle(
                            color: Color(0xFF4a66f0),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}