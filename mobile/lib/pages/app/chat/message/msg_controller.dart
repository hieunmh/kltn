import 'package:get/get.dart';
import 'package:mobile/models/message.dart';
import 'package:mobile/theme/theme_controller.dart';

class MsgController extends GetxController {
  RxList<Message> messages = <Message>[
    Message(
      id: '1', 
      chatid: '1', 
      role: 'user', 
      message: 'Hello',
      updatedAt: '2021-08-01 12:00:00',
      createdAt: '2021-08-01 12:00:00' 
    ),
    Message(
      id: '2', 
      chatid: '1', 
      role: 'assistant', 
      message: 'Hi, how can I help you?',
      updatedAt: '2021-08-01 12:01:00',
      createdAt: '2021-08-01 12:01:00'
    ),
    Message(
      id: '3', 
      chatid: '1', 
      role: 'user', 
      message: 'I have a problem with, ngày Bác Hồ ra đi tìm đường cứu nước?',
      updatedAt: '2021-08-01 12:02:00',
      createdAt: '2021-08-01 12:02:00'
    ),
    Message(
      id: '4', 
      chatid: '1', 
      role: 'assistant', 
      message: 'Chủ tịch Hồ Chí Minh, tên khai sinh là Nguyễn Sinh Cung, đã ra đi tìm đường cứu nước vào ngày 5 tháng 6 năm 1911. Vào ngày này, Người rời cảng Nhà Rồng, Sài Gòn trên con tàu Latouche-Tréville để hướng tới Pháp, bắt đầu hành trình tìm kiếm con đường giải phóng dân tộc Việt Nam.',
      updatedAt: '2021-08-01 12:03:00',
      createdAt: '2021-08-01 12:03:00'
    ),
  ].obs;


  RxString chatName = 'Chat'.obs;

  final ThemeController themeController = Get.find<ThemeController>();
  
}