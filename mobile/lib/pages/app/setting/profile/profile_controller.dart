import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/pages/app/app_controller.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ProfileController extends GetxController {

  final supabaseUrl = '${Env.supabaseUrl}/storage/v1/object/public/';

  final ThemeController themeController = Get.find<ThemeController>();
  final AppController appController = Get.find<AppController>();
  final serverHost = Env.serverhost;

  final ImagePicker imagePicker = ImagePicker();
  Rx<File?> image = Rx<File?>(null);


  final name = ''.obs;
  final email = ''.obs;

  final newName = ''.obs;
  final newEmail = ''.obs;
  final imageUrl = ''.obs;
  final isImageLoading = false.obs;
  final isInfoLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    setInfo();
  }

  Future<void> setInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name.value = prefs.getString('name') ?? '';
    newName.value = prefs.getString('name') ?? '';
    email.value = prefs.getString('email') ?? '';
    newEmail.value = prefs.getString('email') ?? '';
  }

  Future<void> pickImage() async {
    print('pickImage');
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> updateImage() async {
    print('updateImage');
    isImageLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';
    final imageFile = image.value;

    final request = http.MultipartRequest('POST', Uri.parse('$serverHost/user/upload-image'));
    request.headers['cookie'] = rawCookie;

    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
        'user_image', imageFile.path, contentType: MediaType.parse(lookupMimeType(imageFile.path)!)
      ));
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      Get.back();
      appController.imageUrl.value = json.decode(responseBody)['user']['image_url'];
      prefs.setString('image_url', json.decode(responseBody)['user']['image_url']);
    }

    isImageLoading.value = false;

    image.value = null;
  }
  

  Future<void> updateInfo() async {
    print('updateInfo');

    if (newEmail.value == email.value && newName.value == name.value) {
      return;
    }

    isInfoLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final res = await http.patch(Uri.parse('$serverHost/user/update-info'), headers: {
        'Cookie': rawCookie
      },
      body: {
        'newName': newName.value,
        'newEmail': newEmail.value,
      }
    );

    if (res.statusCode == 200) {
      Get.showSnackbar(GetSnackBar(
        message: 'Update info successfully!',
        duration: Duration(seconds: 2),
      ));

      name.value = newName.value;
      email.value = newEmail.value;

      appController.name.value = newName.value;
      appController.email.value = newEmail.value;
      prefs.setString('name', newName.value);
      prefs.setString('email', newEmail.value);
    }

    isInfoLoading.value = false;
  }

  

}