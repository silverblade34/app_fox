import 'package:app_fox/features/splash/bindings/splash_binding.dart';
import 'package:app_fox/features/splash/presentation/pages/splash_page.dart';
import 'package:app_fox/features/vehicles/bindings/vehicles_binding.dart';
import 'package:app_fox/features/vehicles/presentation/pages/vehicles_page.dart';
import 'package:get/get.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
      GetPage(
      name: Routes.vehicles,
      page: () => const VehiclesPage(),
      binding: VehiclesBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
