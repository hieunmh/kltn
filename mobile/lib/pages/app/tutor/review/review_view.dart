import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/tutor/review/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      body: Center(
        child: Text('Review View'),
      ),
    );
  }
}