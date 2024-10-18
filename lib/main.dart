import 'package:app_fox/config/theme.dart';
import 'package:app_fox/routes/pages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WakelockPlus.enable();
  runApp(GetMaterialApp(
    title: "appFox",
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.splash,
    theme: AppTheme.lightTheme,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}
