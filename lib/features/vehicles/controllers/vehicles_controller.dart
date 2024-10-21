import 'package:app_fox/features/vehicles/data/models/vehicle.dart';
import 'package:app_fox/features/vehicles/data/repositories/vehicles_repository.dart';
import 'package:get/get.dart';

class VehiclesController extends GetxController {
  RxList<Vehicle> dataVehicles = RxList();
  VehiclesRepository vehiclesRepository = VehiclesRepository();
  @override
  void onInit() async {
    super.onInit();
    await getVehicles();
  }

  getVehicles() async {
    try {
      final response = await vehiclesRepository.getVehicles();
      dataVehicles.value = response.data;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Ocurrió un error al cargar los vehículos',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
