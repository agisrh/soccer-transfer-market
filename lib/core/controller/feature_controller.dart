import 'package:flutter_xcore/app_core.dart';
import 'package:transfer_market/core/controller/home_controller.dart';

class MyController {
  static HomeController get homeController {
    if (!Get.isRegistered<HomeController>()) {
      Get.lazyPut<HomeController>(() => HomeController());
    }
    return Get.find();
  }
}
