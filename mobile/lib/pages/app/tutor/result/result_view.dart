import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/tutor/result/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Result'),
        ],
      ),
    );
  }
}