import 'package:flutter_study_app/controllers/auth_controller.dart';
import 'package:flutter_study_app/controllers/theme_controller.dart';
import 'package:get/get.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    print(
        "ThemeController registered"); //with help of chatgpt: Sometimes, the Get package might behave lazily,
    Get.put(AuthController(), permanent: true);
    print(
        "AuthController registered"); //so we added these 2 print methods to ensure get.put is executed properly
  }
}
