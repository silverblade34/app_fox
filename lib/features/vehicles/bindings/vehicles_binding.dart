import 'package:app_fox/features/vehicles/controllers/vehicles_controller.dart';
import 'package:get/get.dart';

class VehiclesBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<VehiclesController>(() => VehiclesController());
  }
}