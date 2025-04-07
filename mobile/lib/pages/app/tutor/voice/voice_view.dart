import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/tutor/voice/voice_controller.dart';

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
          child: Column(
            children: [
              Text(
                controller.recognizedWords.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),
          
              GestureDetector(
                onTap: () {
                  if (controller.isListening.value) {
                    controller.stopListening();
                  } else {
                    controller.startListening();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    controller.isListening.value ? BoxIcons.bxs_microphone : BoxIcons.bxs_microphone_off,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}