import 'package:app_fox/features/vehicles/data/models/vehicle.dart';
import 'package:app_fox/features/vehicles/data/providers/vehicles_provider.dart';

class VehiclesRepository {
  VehicleProvider vehicleProvider = VehicleProvider();

  Future<VehicleDto> getVehicles() async {
    print("-----------------------------1");
    final response = await vehicleProvider.getVehicles();
    print("-----------------------------");
    print(response.data);
    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.data["status"] == false) {
      throw Exception(response.data["message"]);
    }
    final body = response.data;
    VehicleDto data = VehicleDto.fromJson(body);
    return data;
  }
}
