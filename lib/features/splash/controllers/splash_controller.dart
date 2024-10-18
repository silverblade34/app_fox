import 'dart:async';

import 'package:app_fox/routes/pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(
      const Duration(seconds: 2),
      () => Get.offNamed(Routes.vehicles),
    );
  }
}
