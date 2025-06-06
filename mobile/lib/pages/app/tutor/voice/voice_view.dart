import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/tutor/voice/voice_controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';

class VoiceView extends GetView<VoiceController> {
  const VoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice'),
      ),  
      body: Obx(() =>
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [            
                Container(
                  height: 100,
                  child: controller.questions.isEmpty ? Center(
                    child: CircularProgressIndicator(
                      color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                      strokeWidth: 3,
                    ),
                  ) : AnimatedTextKit(
                    key: ValueKey(controller.answers.length),
                    animatedTexts: [
                      TypewriterAnimatedText(
                        controller.questions[controller.currentQuestionIndex.value],
                        speed: const Duration(milliseconds: 25),
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),         
                ) ,                    
            
                AvatarGlow(
                  startDelay: const Duration(milliseconds: 1000),
                  glowColor: controller.themeController.isDark.value ? Colors.white : Colors.black,
                  duration: const Duration(milliseconds: 1000), 
                  glowShape: BoxShape.circle,
                  animate: controller.isListening.value,
                  curve: Curves.fastOutSlowIn,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: GestureDetector(
                    onTap: () {
                      if (controller.isListening.value) {
                        controller.stopListening();
                      } else {
                        controller.startListening();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        controller.isListening.value ? BoxIcons.bxs_microphone : BoxIcons.bxs_microphone_off,
                        size: 50,
                        color: controller.themeController.isDark.value ? Colors.black : Colors.white,
                      ),
                    ),
                  )
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    controller.sendAnswer();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}