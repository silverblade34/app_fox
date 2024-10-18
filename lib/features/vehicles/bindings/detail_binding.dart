import 'package:app_fox/features/vehicles/controllers/detail_controller.dart';
import 'package:get/get.dart';

class DetailBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<DetailController>(() => DetailController());
  }
}