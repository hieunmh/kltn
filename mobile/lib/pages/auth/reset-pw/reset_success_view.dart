import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetSuccessView extends StatelessWidget{
  const ResetSuccessView({super.key});

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
                    'Password Changed',
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
                    'No hassle anymore',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              Text(
                'Your password has been reset',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18
                ),
              ),

              Text(
                'Successfully!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child:Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF4a66f0)
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}