import 'package:app_fox/core/constants/assets.dart';
import 'package:app_fox/features/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (splashCntl) {
          return Center(child: Image.asset(AppAssets.splashImage));
        },
      ),
    );
  }
}
