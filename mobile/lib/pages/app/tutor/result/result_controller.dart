import 'package:get/get.dart';
import 'dart:convert';
import 'package:mobile/models/result.dart';

class ResultController extends GetxController {
  
  RxList<String> questions = <String>[].obs;
  RxList<Result> results = <Result>[].obs;

  @override
  void onInit() {
    super.onInit();
    // setQuestions();
    setResults();
  }

  // void setQuestions() {
  //   final rawQuestions = Get.arguments['questions'];
  //   if (rawQuestions is String) {
  //     try {
  //       questions.value = json.decode(rawQuestions);
  //     } catch (e) {
  //       questions.value = [rawQuestions];
  //     }
  //   } else if (rawQuestions is List) {
  //     questions.value = rawQuestions.map((e) => e.toString()).toList();
  //   } else {
  //     questions.value = [];
  //   }
  // }

  void setResults() {
    final rawResults = Get.arguments['results'];
    print('Raw results type: ${rawResults.runtimeType}');
    print('Raw results value: $rawResults');
    
    try {
      if (rawResults is String) {
        final List<dynamic> decodedList = json.decode(rawResults);
        results.value = decodedList.map((item) => Result.fromJson(item)).toList();
      } else if (rawResults is List) {
        results.value = rawResults.map((item) {
          if (item is Map<String, dynamic>) {
            return Result.fromJson(item);
          } else if (item is String) {
            try {
              return Result.fromJson(json.decode(item));
            } catch (e) {
              return Result(evaluate: 0, explain: item.toString());
            }
          }
          return Result(evaluate: 0, explain: item.toString());
        }).toList();
      } else if (rawResults is Map<String, dynamic>) {
        results.value = [Result.fromJson(rawResults)];
      } else {
        results.value = [];
      }
    } catch (e) {
      print('Error parsing results: $e');
      results.value = [];
    }
  }
}