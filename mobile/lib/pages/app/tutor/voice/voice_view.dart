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
              controller.questions.isEmpty ?
              Text(
                'No questions',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ) : Container(
                height: 300,
                child: ListView.builder(
                  itemCount: controller.questions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(controller.questions[index]),
                    );
                  },
                ),
              ),

              controller.questions.isEmpty ? Text(
                'No answers',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ) : Text(
                controller.questions[controller.answers.length],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,  
                ),
              ),

              Text(
                controller.recognizedWords.value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
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